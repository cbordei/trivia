// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var quiz = [{
  "question": "What does CSS stand for?",
  "choices": ["Creative Style Sheets", "Computer Style Sheets", "Cascading Style Sheets"],
  "answer": "Cascading Style Sheets"
}, {
  "question": "Which CSS property controls the text size?",
  "choices": ["text-size", "font-size", "font-style"],
  "answer": "font-size"
}, {
  "question": "What does HTML stand for?",
  "choices": ["Hyperlinks and Text Markup Language", "Hyper Text Markup Language", "Home Tool Markup Language"],
  "answer": "Hyper Text Markup Language"
}];

// {"questions":
// [{"question":
//   {"question":"Ce nu uita niciodata Tatae?",
//   "answers":[
//     {"answer":{"answer":"Banii pa show"}},
//     {"answer":{"answer":"Heroina"}},
//     {"answer":{"answer":"Cartieru"}},
//     {"answer":{"answer":"Veteranii"}}]}},

var QuizContainer = React.createClass( {
  getInitialState: function() {
      return {
        current: 0,
        current_question: questions.questions[ 0 ].question,
        user_choice: "",
        score: 0,
        verifying_answer: false
      };
  },
  selectedAnswer: function( option ) {
    this.setState( { user_choice: option } );
  },
  handleSubmit: function() {
    var url = "answer/"+this.state.user_choice+"/check_answer";    
    
    if ( !this.state.verifying_answer ) {
      $.ajax({
        url: url,
        dataType: 'json',
        type: 'GET',
        success: function(data) {
          this.setState( {
            score: this.state.score + 1,
            correct_answer: data.answer_id
          } );
        }.bind(this),
        error: function(xhr, status, err) {
          this.setState( {
            wrong_answer: xhr.responseJSON.answer_id
          } );
        }.bind(this)
      });
      this.setState( { verifying_answer: true } );
    } else {
      if ( this.state.current < questions.questions.length -1 ) {
        this.setState( {
          current_question: questions.questions[ this.state.current + 1 ].question,
          current: this.state.current + 1,
          verifying_answer: false,
          user_choice: ""
        } );
      }
    }
      
    },
  render: function() {
    var self = this;
    var choices = this.state.current_question.answers.map( function( choice, index ) {
      var classType  = "";
      var answerId = choice.answer.id
      if ( self.state.verifying_answer ) {
        if (self.state.correct_answer === choice.answer.id) {
          classType = "text-success";
        } else if (self.state.wrong_answer === choice.answer.id) {
          classType = "text-danger";
        }
      }
        return (
          <RadioInput key={choice.answer.answer} choice={choice.answer.answer} index={index} onChoiceSelect={self.selectedAnswer} disable={self.state.verifying_answer} classType={classType} answerId = {answerId}/>
        );
      } );
    var button_name = !this.state.verifying_answer ? "Raspunde" : "Urmatoarea Intrebare";
    return(
      <div className="quizContainer">
        <h1>B.U.G. Mafia Quiz</h1>
        <p>{this.state.current_question.question}</p>
        {choices}
        <button id="submit" className="btn btn-default" onClick={this.handleSubmit}>{button_name}</button>
        <ScoreBox score={this.state.score} />
      </div>
    );
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
  document.body
);