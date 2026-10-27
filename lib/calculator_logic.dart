import 'dart:math' as math;

enum Op { add, vichitanie, umnozhenie, delenie }

class Logic {
  String display = '0';
  String expression = '';

  double? firstOp;
  Op? currentOp;
  bool resetDisplay = false;

  void inputN(String number) {
    if (resetDisplay) {
      display = number;
      resetDisplay = false;
    } else if (display == '0') {
      display = number;
    } else {
      display += number;
    }
  }

  void inputD() {
    if (resetDisplay) {
      display = '0.';
      resetDisplay = false;
      return;
    }
    if (!display.contains('.')) {
      display += '.';
    }
  }

  void setOp(Op op) {
    if (currentOp != null && !resetDisplay) {
      calculate();
    }

    firstOp = double.parse(display);
    currentOp = op;
    expression = '$display ${operation(op)}';
    resetDisplay = true;
  }

  void calculate() {
    if (currentOp == null || firstOp == null) return;

    final secondOp = double.parse(display);
    double result;

    switch (currentOp!) {
      case Op.add:
        result = firstOp! + secondOp;
        break;
      case Op.vichitanie:
        result = firstOp! - secondOp;
        break;
      case Op.umnozhenie:
        result = firstOp! * secondOp;
        break;
      case Op.delenie:
        if (secondOp == 0) {
          display = 'Ошибка';
          expression = '';
          reset();
          return;
        }
        result = firstOp! / secondOp;
        break;
    }

    expression = '$expression $display =';
    display = format(result);
    firstOp = null;
    currentOp = null;
    resetDisplay = true;
  }

  void toggleSign() {
    if (display == '0' || display == 'Ошибка') return;

    if (display.startsWith('-')) {
      display = display.substring(1);
    } else {
      display = '-$display';
    }
  }

  void prosent() {
    final value = double.tryParse(display) ?? 0;
    display = format(value / 100);
  }

  void cosinus() {
    final value = double.tryParse(display) ?? 0;
    final radians = value * math.pi / 180;
    final result = math.cos(radians);

    expression = 'cos($display)';
    display = format(result);
    resetDisplay = true;
  }

  void backspace() {
    if (display == 'Ошибка' || resetDisplay) {
      clear();
      return;
    }

    display = display.substring(0, display.length - 1);
  }

  void clear() {
    display = '0';
    expression = '';
    reset();
  }

  void reset() {
    firstOp = null;
    currentOp = null;
    resetDisplay = false;
  }

  String format(double value) {
  String res = value.toString();

  if (res.endsWith(".0")) {
    res = res.substring(0, res.length - 2);
  }

  if (res.contains(".") && res.length > 11) {
    res = value.toStringAsFixed(5);
    while (res.endsWith("0") && res.contains(".")) {
      res = res.substring(0, res.length - 1);
    }
    if (res.endsWith(".")) {
      res = res.substring(0, res.length - 1);
    }
  }

  return res;
}

  String operation(Op op) {
    switch (op) {
      case Op.add:
        return '+';
      case Op.vichitanie:
        return '-';
      case Op.umnozhenie:
        return '*';
      case Op.delenie:
        return '/';
    }
  }
}