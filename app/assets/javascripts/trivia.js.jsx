var QuizContainer = React.createClass( {
  getInitialState: function() {
      return {
        question_count: 0,
        current_question: questions.questions[ 0 ].question,
        user_choice: "",
        score: 0,
        verifying_answer: false
      };
  },
  selectedAnswer: function( option ) {
    this.setState( { user_choice: option } );
    var url = "answer/"+option+"/check_answer";
    setTimeout(((function(_this) {
      return function() {
        if ( !_this.state.verifying_answer && option )  {
          $.ajax({
            url: url,
            dataType: 'json',
            type: 'GET',
            success: function(data) {
              _this.setState( {
                score: _this.state.score + 1,
                correct_answer: data.correct_answer_id
              } );
            }.bind(_this),
            error: function(xhr, status, err) {
              _this.setState( {
                wrong_answer: xhr.responseJSON.wrong_answer_id,
                correct_answer: xhr.responseJSON.correct_answer_id
              } );
            }.bind(_this)
          });
          _this.setState( { verifying_answer: true } );
        }
      };
    })(this)), 1000);
    
    setTimeout(((function(_this) {
      return function() {
        if ( _this.state.question_count < questions.questions.length -1 ) {
          _this.setState( {
            current_question: questions.questions[ _this.state.question_count + 1 ].question,
            question_count: _this.state.question_count + 1,
            verifying_answer: false,
            user_choice: ""
          } );
        } else {
          url = "trivia/ranking/" + _this.state.score
          $.ajax({
            url: url,
            dataType: 'json',
            type: 'GET',
            success: function(data) {          
              _this.setState({rankName: data.rank.rank_name})
            }.bind(this)      
          });
          _this.setState({finished: true})
        }
      };
    })(this)), 2500);
  },  
  render: function() {
    var self = this;
    if (this.state.finished) {
      return(
        <div className="quizContainer">
          <div className="row">
            <div className="center-block custom">
              <h1>B.U.G. Mafia Quiz</h1>
              <div className="final-results">
                Rezultatul tau este {this.state.score} din {questions.questions.length}
                <br/>
                Ai rangul de <b>{this.state.rankName}</b>
              </div>
            </div>
          </div>          
        </div>
      )
    } else {      
      var choices = this.state.current_question.answers.map( function( choice, index ) {
        var classType  = "";
        var answerId = choice.answer.id
        if (self.state.user_choice == choice.answer.id) {
          classType = "active"
        }
        if ( self.state.verifying_answer ) {
          if (self.state.correct_answer === choice.answer.id) {
            classType = "success";
          } else if (self.state.wrong_answer === choice.answer.id) {
            classType = "error";
          }
        }
          return (
            <RadioInput key={choice.answer.answer} choice={choice.answer.answer} index={index} onChoiceSelect={self.selectedAnswer} disable={self.state.verifying_answer} classType={classType} answerId = {answerId}/>
          );
      } );
      var complete = Math.round(self.state.question_count * 100 / questions.questions.length)
      var progresStyle = {
        width: complete+"%"
      };
      return(
        <div className="quizContainer">
          <div className="row">
            <div className="center-block custom">
              <h1>B.U.G. Mafia Quiz</h1>
              <div className="question-title">
                <p>{this.state.current_question.question}</p>
              </div>  
              <div id="choises">
                {choices}
              </div>
              <div className="progress custom-progress">
                <div className="progress-bar" role="progressbar" aria-valuenow="70"
                 aria-valuemin="0" aria-valuemax="100" style={progresStyle}>
                  {complete}%
                </div>
              </div>
              <ScoreBox score={this.state.score} current_question={this.state.question_count} />
            </div>
          </div>          
        </div>
      );
    }    
  }
} );

var RadioInput = React.createClass( {
  handleClick: function() {
    this.props.onChoiceSelect( this.props.answerId );
  },
  render: function() {
    var disable = this.props.disable;
    var classString = !disable ?  "radio" :  "radio disabled";
    return (
      <div className={classString}>
        <label className={this.props.classType}>
          <input type="radio" name="optionsRadios" id={this.props.index} value={this.props.choice} onChange={this.handleClick} disabled={disable} />
          {this.props.choice}
        </label>
      </div>
    );
  }
} );

var ScoreBox = React.createClass( {
  render: function() {  
    return (      
      <div className="score">        
        <p>Scor: {this.props.score} raspunsuri corecte din {questions.questions.length} possible.</p>
      </div>
    );
  }
} );

React.render(
  <QuizContainer />,
  document.querySelector('#js-quiz-container')
);