const guess = document.getElementById("code_guess")

const form = document.getElementById("input_guess")

const reset_guess = function () {
  guess.value = ""
  guessed_code = []
  position = 0

  turn = form.getAttribute("turn")
  for (var p = 0; p < 4; p++) {
    var peg_id = "turn" + turn + "peg" + p
    var peg = document.getElementById(peg_id)
    peg.style = "font-size:36px;color:rgb(77, 77, 77);"
    peg.innerHTML = "panorama_fish_eye"
  }
  return true
}


const set_peg = function (color, turn) {

  if (position == 4) position = 0
  var peg_id = "turn" + turn + "peg" + position
  var peg = document.getElementById(peg_id);

  peg.style = "font-size:36px;color:" + color
  peg.innerHTML = "lens"
  guessed_code[position] = color
  guess.value = guessed_code

  position += 1
  return true
}


var position = 0
var guessed_code = []
form.addEventListener("reset", reset_guess)


