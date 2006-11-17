Message-ID: <455DC446.8010307@domain.hid>
Date: Fri, 17 Nov 2006 15:16:38 +0100
From: Dirk Eibach <eibach@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060000020508040105080603"
Subject: [Xenomai-core] Re: [Xenomai-help] Draft for a RTDM I2C driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060000020508040105080603
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>> At the moment the devicename is defined by the caller of
>> rti2c_adapter_register().
>> When the device is registered a number is assigned to the adapter. Maybe
>> the devicename could be made up of some fixed text like "rti2c" followed
>> by the number that is assigned to the adapter.
> 
> That was the idea behind it. Given the RTI2C is generic (and it looks
> like it is), you can than write a generic application, opening "rti2c0"
> more or less blindly without knowing the adapter behind it.

Fixed.

>>>>   // set the address of the device on the bus
>>>>   rt_dev_ioctl(fd, RTI2C_SLAVE, addr);
>>> Is the typical use case to not change the slave address that often,
>>> rather to use separate device instances for accessing different slaves?
>>> I'm wondering if a combined address+request command may make sense.
>>> Maybe even a socket-based protocol device would match as well, maybe
>>> even better... (needs more thinking, I guess)
>>>
>>> Does Linux expose a similar API via some character devices? Keeping the
>>> distance to Linux low might be a reason to not go the socket path.
>> The linux API is exactly the same. I had the same thoughts concerning
>> combined commands (address+request) but maybe we could offer such
>> commands as wrappers.
> 
> My concern was rather about performance than convenience. If a usage
> pattern consists of almost as many address-set driver invocations as
> actual requests, then you would benefit quite a lot from a combined
> service call. But the question is, given that Linux uses the same API,
> if that is really an expected use case and worth an optimisation effort.

For the moment I'll keep it the way it is.

> ...
>>> A few thoughts on this:
>>>
>>>  - What are typical delays between 4. and 5.? Does it makes sense for
>>>    short requests to busy-wait (to avoid the scheduler/IRQ overhead)?
>>>    I've seen that there is some polling path included in the code, but
>>>    that would break as it calls into Linux.
>> Oops. I missed that schedule() call. Regarding typical delays I have to
>> admit that I have not measured yet, but I would estimate about 500 us
>> for the above usecase. What would you estimate the scheduler/IRQ overhead?
> 
> Oh, 500 us is far more than you should see as "suspend-me +
> switch-to-someone-else + raise-irq-and-switch-back-to-me" overhead even
> on low-end PPC. Busy-waiting is something for a few microseconds.

Ah, all right, so I leave this as is too.

>>>  - Will a request always return? Or does it make sense to establish an
>>>    (optional) timeout mechanism here?
>> A timeout mechanism is already there: rti2c_ppc4xx_wait_for_tc() uses
>> rtdm_event_timedwait to wait for the interrupt to complete. Certainly
>> that is left to the implementation of the adapter.
> 
> True, I missed this.
> 
>>>  - Buffer allocation for short requests may also happen on the stack, I
>>>    think.
>> That is already done. Have a look at the RTI2C_SMBUS IOCTL. Do you think
>> it should also be possible to do this in the read/write calls denpending
>> on the requested size?
> 
> I currently see allocations in RTI2C_RDWR (BTW, there is a forgotten
> kmalloc) and in read/write. As I don't know the typical sizes of those
> requests, I cannot judge on this. So take it as some food to think about.
> 
> In contrast, the rtdm_malloc on adapter registration is overkill - this
> will not happen in RT context, will it?

Fixed. Still not sure what to do about the memory allocations in the
other places.

>>>  - Buffer allocation for large requests may (optionally) happen
>>>    ahead-of-time via some special IOCTL. This would make a device
>>>    independent of the current system heap usage/fragmentation.
>>>
>>>  - During concurrent use, the latency of an user is defined by its
>>>    priority, of course, and the number and lengths of potentially issued
>>>    request of some lower priority user, right? Is there a way one could
>>>    intercept a pending request list? Or is this list handled in toto to
>>>    the hardware? Melts down to "how to manage the bandwidth according to
>>>    the user's priority".
>> Concurrent use means that single RTI2C requests are called from
>> different tasks. Each request is atomic (and usually quite small). So
>> when a low-pri thread does a lot of requests a high-pri thread can get
>> inbetween anytime. I think this way bandwidth is already managed properly.
> 
> So there is no interface where you can submit several requests as an
> atomic chunk? Then I'm fine with what we have.

As far as I can see there is no atomic chunk support.

..

I attached the changes as a patch.
I'll have a closer look at documentation and api next week.

Dirk



--------------060000020508040105080603
Content-Type: application/octet-stream;
 name="rti2c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="rti2c.patch"

SW5kZXg6IGJ1c3Nlcy9ydGkyYy1wcGM0eHguYw0KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIGJ1c3Nl
cy9ydGkyYy1wcGM0eHguYwkoUmV2aXNpb24gNSkNCisrKyBidXNzZXMvcnRpMmMtcHBjNHh4
LmMJKEFyYmVpdHNrb3BpZSkNCkBAIC02Miw3ICs2Miw3IEBADQogbW9kdWxlX3BhcmFtKHJ0
aTJjX3BwYzR4eF9mb3JjZV9mYXN0LCBib29sLCAwKTsNCiBNT0RVTEVfUEFSTV9ERVNDKHJ0
aTJjX3BwYzR4eF9mYXN0X3BvbGwsICJGb3JjZSBmYXN0IG1vZGUgKDQwMCBrSHopIik7DQog
DQotI2RlZmluZSBEQkdfTEVWRUwgMw0KKyNkZWZpbmUgREJHX0xFVkVMIDANCiANCiAjaWZk
ZWYgREJHDQogI3VuZGVmIERCRw0KQEAgLTQwNSw3ICs0MDUsNyBAQA0KIAkJCXJ0aTJjX3Bw
YzR4eF9kZXZfcmVzZXQoZGV2KTsNCiAJCQlyZXR1cm47DQogCQl9DQotCQlzY2hlZHVsZSgp
Ow0KKwkJcnRkbV90YXNrX3NsZWVwKDEpOw0KIAl9DQogDQogCS8qIEp1c3QgdG8gY2xlYXIg
ZXJyb3JzICovDQpAQCAtNzY0LDcgKzc2NCw3IEBADQogCWFkYXAtPnRpbWVvdXQgPSAxOw0K
IAlhZGFwLT5yZXRyaWVzID0gMTsNCiAJDQotCXJldCA9IHJ0aTJjX2FkYXB0ZXJfcmVnaXN0
ZXIoYWRhcCwgInJ0aTJjcHBjNHh4Iik7DQorCXJldCA9IHJ0aTJjX2FkYXB0ZXJfcmVnaXN0
ZXIoYWRhcCk7DQogCXJ0ZG1fcHJpbnRrKCJpYm0taWljJWQ6IHVzaW5nICVzIG1vZGVcbiIs
IGRldi0+aWR4LA0KIAkJZGV2LT5mYXN0X21vZGUgPyAiZmFzdCAoNDAwIGtIeikiIDogInN0
YW5kYXJkICgxMDAga0h6KSIpOw0KIA0KSW5kZXg6IHJ0aTJjLmgNCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Ci0tLSBydGkyYy5oCShSZXZpc2lvbiA1KQ0KKysrIHJ0aTJjLmgJKEFyYmVpdHNrb3BpZSkN
CkBAIC0xMDAsOCArMTAwLDcgQEANCiAvKiBBZGFwdGVyIHJlZ2lzdHJhdGlvbiAqLw0KIHN0
cnVjdCBydGkyY19hZGFwdGVyICpydGkyY19hZGFwdGVyX2FsbG9jKHZvaWQpOw0KIHZvaWQg
cnRpMmNfYWRhcHRlcl9mcmVlKHN0cnVjdCBydGkyY19hZGFwdGVyICopOw0KLWludCBydGky
Y19hZGFwdGVyX3JlZ2lzdGVyKHN0cnVjdCBydGkyY19hZGFwdGVyICphZGFwdGVyLCANCi0J
Y29uc3QgY2hhciogcnRkbV9kZXZpY2VfbmFtZSk7DQoraW50IHJ0aTJjX2FkYXB0ZXJfcmVn
aXN0ZXIoc3RydWN0IHJ0aTJjX2FkYXB0ZXIgKmFkYXB0ZXIpOw0KIGludCBydGkyY19hZGFw
dGVyX3VucmVnaXN0ZXIoc3RydWN0IHJ0aTJjX2FkYXB0ZXIgKmFkYXB0ZXIpOw0KIA0KIC8q
IFJldHVybiB0aGUgZnVuY3Rpb25hbGl0eSBtYXNrICovDQpJbmRleDogcnRpMmMtY29yZS5j
DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQotLS0gcnRpMmMtY29yZS5jCShSZXZpc2lvbiA1KQ0KKysrIHJ0
aTJjLWNvcmUuYwkoQXJiZWl0c2tvcGllKQ0KQEAgLTI2LDYgKzI2LDggQEANCiAgKi8NCiAN
CiAjaW5jbHVkZSAicnRpMmMuaCINCisjaW5jbHVkZSA8YXNtL2lvLmg+DQorI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4NCiANCiAjZGVmaW5lIFJUSTJDX01BWF9BREFQVEVSUyA1DQogDQpA
QCAtNDMsMTYgKzQ1LDEyIEBADQogew0KIAlzdHJ1Y3QgcnRpMmNfYWRhcHRlciAqYWRhcHRl
cjsNCiAJDQotCWFkYXB0ZXIgPSAoc3RydWN0IHJ0aTJjX2FkYXB0ZXIgKilydGRtX21hbGxv
YyhzaXplb2YoKmFkYXB0ZXIpKTsNCisJYWRhcHRlciA9IGt6YWxsb2Moc2l6ZW9mKCphZGFw
dGVyKSwgR0ZQX0tFUk5FTCk7DQogCWlmICghYWRhcHRlcikgew0KIAkJcnRkbV9wcmludGso
InJ0aTJjLWNvcmU6IGNhbm5vdCBhbGxvY2F0ZSBydGkyY19hZGFwdGVyXG4iKTsNCiAJCXJl
dHVybiBOVUxMOw0KIAl9DQotCW1lbXNldChhZGFwdGVyLCAwLCBzaXplb2YoKmFkYXB0ZXIp
KTsNCiAJbWVtY3B5KCZhZGFwdGVyLT5kZXYsICZydGkyY19kZXZpY2UsIHNpemVvZihhZGFw
dGVyLT5kZXYpKTsNCi0JcnRkbV9wcmludGsoImFkYXB0ZXItPmRldi5wcm9jX25hbWUgPSAl
cywiDQotCQkiIHJ0aTJjX2RldmljZS5wcm9jX25hbWUgPSAlc1xuIiwgDQotCQlhZGFwdGVy
LT5kZXYucHJvY19uYW1lLCBydGkyY19kZXZpY2UucHJvY19uYW1lKTsNCiAJcnRkbV9tdXRl
eF9pbml0KCZhZGFwdGVyLT5idXNfbG9jayk7DQogCQ0KIAlyZXR1cm4gYWRhcHRlcjsNCkBA
IC02MSwxMSArNTksMTAgQEANCiB2b2lkIHJ0aTJjX2FkYXB0ZXJfZnJlZShzdHJ1Y3QgcnRp
MmNfYWRhcHRlciAqYWRhcHRlcikNCiB7DQogCXJ0ZG1fbXV0ZXhfZGVzdHJveSgmYWRhcHRl
ci0+YnVzX2xvY2spOw0KLQlydGRtX2ZyZWUoYWRhcHRlcik7DQorCWtmcmVlKGFkYXB0ZXIp
Ow0KIH0NCiANCi1pbnQgcnRpMmNfYWRhcHRlcl9yZWdpc3RlcihzdHJ1Y3QgcnRpMmNfYWRh
cHRlciAqYWRhcHRlciwgDQotCWNvbnN0IGNoYXIqIHJ0ZG1fZGV2aWNlX25hbWUpDQoraW50
IHJ0aTJjX2FkYXB0ZXJfcmVnaXN0ZXIoc3RydWN0IHJ0aTJjX2FkYXB0ZXIgKmFkYXB0ZXIp
DQogew0KIAl1bnNpZ25lZCBpbnQgaTsNCiAJaW50IG4gPSAtMTsNCkBAIC03Niw2ICs3Myw3
IEBADQogCWZvciAoaSA9IDA7IGkgPCBSVEkyQ19NQVhfQURBUFRFUlM7IGkrKykgew0KIAkJ
aWYgKHJ0aTJjX2FkYXB0ZXJzW2ldID09IE5VTEwpIHsNCiAJCQluID0gaTsNCisJCQlicmVh
azsNCiAJCX0NCiAJfQ0KIAlpZiAobiA8IDApIHsNCkBAIC04NSw4ICs4Myw4IEBADQogDQog
CXJ0ZG1fbXV0ZXhfdW5sb2NrKCZydGkyY19tdXRfYWRhcHRlcnMpOw0KIAkNCi0JbWVtY3B5
KGFkYXB0ZXItPmRldi5kZXZpY2VfbmFtZSwgcnRkbV9kZXZpY2VfbmFtZSwgDQotCQlzaXpl
b2YoYWRhcHRlci0+ZGV2LmRldmljZV9uYW1lKSk7DQorICAgICAgICBzbnByaW50ZihhZGFw
dGVyLT5kZXYuZGV2aWNlX25hbWUsIHNpemVvZihhZGFwdGVyLT5kZXYuZGV2aWNlX25hbWUp
LA0KKwkJInJ0aTJjJWQiLCBuKTsNCiAJYWRhcHRlci0+ZGV2LnByb2NfbmFtZSA9IGFkYXB0
ZXItPmRldi5kZXZpY2VfbmFtZTsNCiAJYWRhcHRlci0+ZGV2LmRldmljZV9pZCA9IG47DQog
CQ0KQEAgLTk0LDggKzkyLDEwIEBADQogCWlmIChyZXQpIHsNCiAJCXJ0ZG1fcHJpbnRrKCJy
dGkyYy1jb3JlOiBjYW5ub3QgcmVnaXN0ZXIgcnRkbS1kZXZpY2UgJXNcbiIsDQogCQkJYWRh
cHRlci0+ZGV2LmRldmljZV9uYW1lKTsNCisJfSBlbHNlIHsNCisJCXJ0ZG1fcHJpbnRrKCJy
dGkyYy1jb3JlOiBhZGFwdGVyICVzIHJlZ2lzdGVyZWRcbiIsDQorCQkJYWRhcHRlci0+ZGV2
LmRldmljZV9uYW1lKTsNCiAJfQ0KLQkNCiAJcmV0dXJuIHJldDsNCiB9DQogDQpAQCAtNjMy
LDcgKzYzMiw3IEBADQogCQkJCWJyZWFrOw0KIAkJCX0NCiAJCQlkYXRhX3B0cnNbaV0gPSAo
dTggX191c2VyICopcmR3cl9wYVtpXS5idWY7DQotCQkJcmR3cl9wYVtpXS5idWYgPSBrbWFs
bG9jKHJkd3JfcGFbaV0ubGVuLCBHRlBfS0VSTkVMKTsNCisJCQlyZHdyX3BhW2ldLmJ1ZiA9
IHJ0ZG1fbWFsbG9jKHJkd3JfcGFbaV0ubGVuKTsNCiAJCQlpZihyZHdyX3BhW2ldLmJ1ZiA9
PSBOVUxMKSB7DQogCQkJCXJlcyA9IC1FTk9NRU07DQogCQkJCWJyZWFrOw0K
--------------060000020508040105080603--




