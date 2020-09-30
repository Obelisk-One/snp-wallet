/*
 * 项目名:    snp
 * 包名       base.utils
 * 文件名:    object_util
 * 创建时间:  2020/8/25 on 11:28 AM
 * 描述:     
 *
 * @author   Dino
 */

T _from<F, T>(F f, Type type) {
  if (f == null) return null;

  dynamic f_ = f;
  var t;
//	switch(F){
  switch (f.runtimeType) {
    case String:
//			switch(T){
      switch (type) {
        case String:
          t = f_;
          break;
        case int:
          t = str2int(f_);
          break;
        case double:
          t = str2double(f_);
          break;
        case bool:
          t = str2bool(f_);
          break;
      }
      break;
    case int:
      switch (type) {
        case String:
          t = int2str(f_);
          break;
        case int:
          t = f_;
          break;
        case double:
          t = int2double(f_);
          break;
        case bool:
          t = int2bool(f_);
          break;
      }
      break;
    case double:
      switch (type) {
        case String:
          t = double2str(f_);
          break;
        case int:
          t = double2int(f_);
          break;
        case double:
          t = f_;
          break;
        case bool:
          t = double2bool(f_);
          break;
      }
      break;
    case bool:
      switch (type) {
        case String:
          t = bool2str(f_);
          break;
        case int:
          t = bool2int(f_);
          break;
        case double:
          t = bool2double(f_);
          break;
        case bool:
          t = f_;
          break;
      }
      break;
  }
  return t;
}

String toString<T>(T v) {
  return _from<T, String>(v, String);
}

int toInt<T>(T v) {
  return _from<T, int>(v, int);
}

double toDouble<T>(T v) {
  return _from<T, double>(v, double);
}

bool toBool<T>(T v) {
  return _from<T, bool>(v, bool);
}

int str2int(String v) {
  return v == null ? 0 : int.parse(v);
}

String int2str(int v) {
  return v == null ? '' : v.toString();
}

double str2double(String v) {
  return v == null ? 0.0 : double.parse(v);
}

String double2str(double v) {
  return v == null ? '' : v.toString();
}

bool str2bool(String v) {
  return v == null
      ? false
      : ['true', '1', 'y', 'yes', '是'].contains(v.trim().toLowerCase());
}

String bool2str(bool v) {
  return v == null ? '' : v.toString();
}

double int2double(int v) {
  return v == null ? 0.0 : v.toDouble();
}

int double2int(double v) {
  return v = null ? 0 : v.toInt();
}

bool int2bool(int v) {
  return v == null ? false : v == 1;
}

int bool2int(bool v) {
  return v == null ? 0 : v ? 1 : 0;
}

bool double2bool(double v) {
  return v == null ? false : v == 1.0;
}

double bool2double(bool v) {
  return v == null ? 0.0 : v ? 1.0 : 0.0;
}

// TODO 如何判断泛型的继承关系
T fromString<T>(String v) {
  var _v;
  if (identical(T, int))
    _v = int.parse(v);
  else if (identical(T, double))
    _v = double.parse(v);
  else if (identical(T, bool))
    _v = ['true', '1', 'y', 'yes', '是'].contains(v.trim().toLowerCase());
  else if (identical(T, String)) _v = v;
  return _v as T;
}

T nullIf<T>(T exp1, T exp2) {
  if (exp1 == exp2) return null;
  return exp1;
}

// 返回第一个非null表达式
dynamic ifNull(
    Object value, [
      Object replaceValue1,
      Object replaceValue2,
      Object replaceValue3,
      Object replaceValue4,
      Object replaceValue5,
    ]) {
//	Object returnValue;
//	for(Object v in [value, replaceValue1, replaceValue2, replaceValue3, replaceValue4, replaceValue5]){
//		if(v != null){
//			returnValue = v;
//			break;
//		}
//	}
  Object returnValue = value ??
      replaceValue1 ??
      replaceValue2 ??
      replaceValue3 ??
      replaceValue4 ??
      replaceValue5;
  if (returnValue == null) {
    // TODO null变量丢失了变量类型，需要找到方法去处理
    if (value is String)
      returnValue = '';
    else if (value is int)
      returnValue = 0;
    else if (value is double)
      returnValue = 0.0;
    else if (value is bool)
      returnValue = false;
    else if (value is List)
      returnValue = [];
    else if (value is Map)
      returnValue = {};
    else if (value is Function)
      value = () {};
    else if (value is dynamic)
      null;
    else if (value is Type)
      null;
    else if (value is Object)
      null;
    else
      throw Exception('unsupported type <${value.runtimeType}>');
  }
  return returnValue;
}

// 返回第一个非empty表达式: empty字符串-0长度或null字符串; empty数字-0或null数字
dynamic ifEmpty(Object value, Object replaceValue) {
//	Object returnValue = ifNull(value);
//	if(returnValue is String && returnValue.trim().isEmpty) returnValue = replaceValue;
//	else if(returnValue is int && returnValue == 0) returnValue = replaceValue;
//	else if(returnValue is double && returnValue == 0.0) returnValue = replaceValue;
//	else if(returnValue is List && returnValue.isEmpty) returnValue = replaceValue;
//	else if(returnValue is Map && returnValue.isEmpty) returnValue = replaceValue;
//	return returnValue;
  if (isEmpty(value))
    return replaceValue;
  else
    return value;
}

bool isNotEmpty(Object value) {
  return !isEmpty(value);
}

bool isEmpty(Object value) {
  if (value == null) return true;
  if (value is String && value.trim().isEmpty) return true;
  if (value is num && value == 0) return true;
  if (value is List && (value.isEmpty || value.length <= 0)) return true;
  if (value is Map && value.isEmpty) return true;
  return false;
}

void fillNull(Object value) {
  if (value is Map) {
    Map m = value;
    for (var k in m.keys) {
      Object v = m[k];
      if (v is Map || v is List)
        fillNull(v);
      else {
        m[k] = ifNull(v);
      }
    }
  } else if (value is List) {
    List l = value;
    int index = 0;
    for (var i in l) {
      if (i is Map || i is List)
        fillNull(i);
      else {
        l[index] = ifNull(i);
      }
      index++;
    }
  }
}