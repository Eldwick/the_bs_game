function checkAnswer(e){
  if ($(e).data("truth")){
    alert("Correct!")
  } else {
    alert("Nope! Try again!")
  }
}