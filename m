Message-ID: <ff1d78710809020518o6bc21376k6d06544754b85aa@domain.hid>
Date: Tue, 2 Sep 2008 14:18:18 +0200
From: "Steven Kauffmann" <steven.kauffmann@domain.hid>
In-Reply-To: <48BD13F1.2010300@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4297_18941921.1220357898268"
References: <ff1d78710809020250g57e6d871kf9284a46ae4685ec@domain.hid>
	<48BD13F1.2010300@domain.hid>
Subject: Re: [Xenomai-help] Kernel Oops calling rt_dev_close
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_4297_18941921.1220357898268
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Sep 2, 2008 at 12:22 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Steven Kauffmann wrote:
>> Hi all,
>>
>> I'm getting Kernel oops when calling rt_dev_close in my application
>> [*]. The application creates a new real-time task and in this task
>> rt_dev_recvfrom is waiting for incoming CAN messages.
>>
>> In the close function of the application I first call rt_dev_close and
>> after that I kill the thread with rt_task_delete. I also wait for the
>> termination of this thread with rt_task_join. But when rt_dev_close is
>> called, the kernel oops occurs.
>
> Do you have a (small) test case for this issue? Does it work with a
> virtual CAN device as well? That would be the fastest way to track down
> the issue.

The test case (see attached file) reproduces the kernel oops.

The kernel oops also occurs when using the virtual CAN device.

> Otherwise, some disassembly of drivers/xenomai/can/rtcan_socket.o would
> be nice (objdump -drS). Also, enabling CONFIG_IPIPE_TRACE_PANIC would
> enrich the backtrace with some longer function call history. But, again,
> local reproducibility would be best.
>
> Jan
>
>

------=_Part_4297_18941921.1220357898268
Content-Type: text/x-csrc; name=rtcan.c
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fkmhhtmg1
Content-Disposition: attachment; filename=rtcan.c

I2luY2x1ZGUgPHJ0ZG0vcnRjYW4uaD4KI2luY2x1ZGUgPG5hdGl2ZS90YXNrLmg+CgojaW5jbHVk
ZSA8c3lzL21tYW4uaD4KCiNkZWZpbmUgVEFTS19QUklPICA5OSAvKiBIaWdoZXN0IFJUIHByaW9y
aXR5ICovCiNkZWZpbmUgVEFTS19NT0RFICBUX0pPSU5BQkxFIC8qIEZsYWdzICovCgpSVF9UQVNL
IHRhc2s7ClJUX1RBU0sgcmVhZF9jYW5fdGFzazsKCmludCBzb2NrZXRfaWQ7CnN0cnVjdCBpZnJl
cSBpZnI7CnN0cnVjdCBzb2NrYWRkcl9jYW4gYWRkcjsKCnZvaWQgcmVhZF9jYW4oKSAKewogIHN0
cnVjdCBjYW5fZnJhbWUgZnJhbWU7CiAgc3RydWN0IHNvY2thZGRyX2NhbiByZWN2YWRkcjsKICBz
b2NrbGVuX3QgYWRkcmxlbiA9IHNpemVvZihyZWN2YWRkcik7CiAgd2hpbGUoMSkKICAgICBydF9k
ZXZfcmVjdmZyb20oc29ja2V0X2lkLCAodm9pZCAqKSZmcmFtZSwgc2l6ZW9mKGNhbl9mcmFtZV90
KSwgMCwKCQkJICAgICAgIChzdHJ1Y3Qgc29ja2FkZHIgKikmcmVjdmFkZHIsICZhZGRybGVuKTsK
fQoKCmludCBtYWluKCkgewogIGludCByZXQ7CiAgCiAgbWxvY2thbGwoTUNMX0NVUlJFTlR8TUNM
X0ZVVFVSRSk7CgogIHJ0X3Rhc2tfc2hhZG93KCZ0YXNrLCAwLCBUQVNLX1BSSU8sIFRBU0tfTU9E
RSk7CgogIHNvY2tldF9pZCA9IHJ0X2Rldl9zb2NrZXQoUEZfQ0FOLCBTT0NLX1JBVywgQ0FOX1JB
Vyk7CiAgaWYgKHNvY2tldF9pZCA8IDApIHsKICAgIHByaW50ZigiQ2Fubm90IG9wZW4gc29ja2V0
LCBlcnJvciAlZFxuIiwgc29ja2V0X2lkKTsKICAgIHJldHVybiAtMTsKICB9CgogIHN0cmNweShp
ZnIuaWZyX25hbWUsICJydGNhbjAiKTsKCiAgcmV0ID0gcnRfZGV2X2lvY3RsKHNvY2tldF9pZCwg
U0lPQ0dJRklOREVYLCAmaWZyKTsKICBpZihyZXQpIHsKICAgIHByaW50ZigicnRfZGV2X2lvY3Rs
IGVycm9yICVkXG4iLCByZXQpOwogICAgcmV0dXJuIC0xOwogIH0KICAKICBhZGRyLmNhbl9mYW1p
bHkgPSBBRl9DQU47ICAKICBhZGRyLmNhbl9pZmluZGV4ID0gaWZyLmlmcl9pZmluZGV4OwogIAog
IHJldCA9IHJ0X2Rldl9iaW5kKHNvY2tldF9pZCwgKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRyLCBz
aXplb2YoYWRkcikpOwogIGlmKHJldCkgewogICAgcHJpbnRmKCJjYW5ub3QgYmluZCwgZXJyb3Ig
JWRcbiIsIHJldCk7CiAgICByZXR1cm4gLTE7CiAgfQoKICByZXQgPSBydF90YXNrX2NyZWF0ZSgm
cmVhZF9jYW5fdGFzaywgIlJlYWQgY2FuIHJ0Y2FuMCIsIDAsIFRBU0tfUFJJTywgVF9KT0lOQUJM
RSk7CiAgaWYocmV0KSB7CiAgICBwcmludGYoImNhbm5vdCBjcmVhdGUgdGFzaywgZXJyb3IgJWRc
biIsIHJldCk7CiAgICByZXR1cm4gLTE7CiAgfQogIAogIHJldCA9IHJ0X3Rhc2tfc3RhcnQoJnJl
YWRfY2FuX3Rhc2ssICZyZWFkX2NhbiwgTlVMTCk7CiAgaWYocmV0KSB7CiAgICBwcmludGYoIkNh
bm5vdCBzdGFydCB0YXNrLCBlcnJvciAlZFxuIiwgcmV0KTsKICAgIHJldHVybiAtMTsKICB9CiAg
CiAgc2xlZXAoMik7CiAgCiAgcmV0ID0gcnRfZGV2X2Nsb3NlKHNvY2tldF9pZCk7CiAgaWYocmV0
KSB7CiAgICBwcmludGYoIkNhbm5vdCBjbG9zZSBzb2NrZXQsIGVycm9yICVkXG4iLCByZXQpOwog
ICAgcmV0dXJuIC0xOwogIH0KCiAgcmV0ID0gcnRfdGFza19kZWxldGUoJnJlYWRfY2FuX3Rhc2sp
OwogIGlmKHJldCkgewogICAgcHJpbnRmKCJFcnJvciB3aGlsZSBkZWxldGluZyB0aGUgUlQgdGFz
ayAlZFxuIiwgcmV0KTsKICAgIHJldHVybiAtMTsKICB9CgogIHJldCA9IHJ0X3Rhc2tfam9pbigm
cmVhZF9jYW5fdGFzayk7CiAgaWYocmV0KSB7CiAgICBwcmludGYoIkVycm9yIHdoaWxlIGpvaW5p
bmcgdGhlIFJUIHRhc2sgJWRcbiIsIHJldCk7CiAgICByZXR1cm4gLTE7CiAgfQoKICByZXR1cm4g
MDsKfQo=
------=_Part_4297_18941921.1220357898268--

