<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="approveProgress.aspx.cs" Inherits="ITTacker.approveProgress" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
.multi-steps .li-bar.is-active:before, .multi-steps .li-bar.is-active ~ li:before {
  content: counter(stepNum);
  font-family: inherit;
  font-weight: 700;
}
.multi-steps .li-bar.is-active:after, .multi-steps .li-bar.is-active ~ li:after {
  background-color: #ededed;
}

.multi-steps {
  display: table;
  table-layout: fixed;
  width: 100%;
}
.multi-steps .li-bar {
  counter-increment: stepNum;
  text-align: center;
  display: table-cell;
  position: relative;
  color: tomato;
}
.multi-steps .li-bar:before {
  content: '\f00c';
  content: '\2713;';
  content: '\10003';
  content: '\10004';
  content: '\2713';
  display: block;
  margin: 0 auto 4px;
  background-color: #fff;
  width: 36px;
  height: 36px;
  line-height: 32px;
  text-align: center;
  font-weight: bold;
  border-width: 2px;
  border-style: solid;
  border-color: tomato;
  border-radius: 50%;
}
.multi-steps .li-bar:after {
  content: '';
  height: 2px;
  width: 100%;
  background-color: tomato;
  position: absolute;
  top: 16px;
  left: 50%;
  z-index: -1;
}
.multi-steps .li-bar:last-child:after {
  display: none;
}
.multi-steps .li-bar.is-active:before {
  background-color: #fff;
  border-color: tomato;
}
.multi-steps .li-bar.is-active ~ li-bar {
  color: #808080;
}
.multi-steps .li-bar.is-active ~ li:before {
  background-color: #ededed;
  border-color: #ededed;
}

</style>
</head>
<body>
    <form id="form1" runat="server">
       <ul class="list-unstyled multi-steps">
    <li class="li-bar">Start</li>
    <li class="li-bar">First Step</li>
    <li class="li-bar is-active">Middle Stage</li>
    <li class="li-bar">Finish</li>
  </ul>
    </form>
</body>
</html>
