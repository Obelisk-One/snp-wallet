/*
 * 项目名:    snp
 * 包名       base
 * 文件名:    base_exception
 * 创建时间:  2020/8/25 on 4:35 PM
 * 描述:     
 *
 * @author   Dino
 */

abstract class BaseException extends FormatException {
  final int code;
  BaseException(Object message, {int code})
      : code = code,
        super(message);

  @override
  String toString() {
    return super.message;
  }
}

// 底层持久化异常，例如‘网络故障’等
class NetException extends BaseException {
  NetException(Object message, {int code}) : super(message, code: code);

  @override
  String toString() {
    return '网络错误：${super.message} ${super.code}';
  }
}
class OrderException extends BaseException {
  OrderException(Object message, {int code}) : super(message, code: code);

  @override
  String toString() {
    return '订单错误\n${super.message} \n错误代码${super.code}';
  }
}

// 业务层异常，各类业务错误，包含领域层和服务层（服务层也称为应用层）
class TransactionException extends BaseException {
  TransactionException(Object message, {int code}) : super(message, code: code);
}

// 领域层异常，例如‘用户无权限’等
class DomainException extends TransactionException {
  DomainException(Object message, {int code}) : super(message, code: code);
}

// 服务层异常，例如‘该鉴定申请已无鉴定师名额’
class ServiceException extends TransactionException {
  ServiceException(Object message, {int code}) : super(message, code: code);
}

void checkSessionError(error) {
  if (isSessionError(error)) throw error;
}

bool isSessionError(error) {
  return error is DomainException && error.code == -3;
}
