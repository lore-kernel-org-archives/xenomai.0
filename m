MIME-Version: 1.0
In-Reply-To: <1304262109.2063.4.camel@domain.hid>
References: <mailman.6356.1286778008.12503.xenomai@xenomai.org>
	<7504E039-6366-480F-ACA3-018E520122E6@domain.hid>
	<AANLkTin__DMjjDxFzBCOiA1Z+ODq01KA6FSWSzEwET3y@domain.hid>
	<AANLkTik=JkttWXUj5Zm04cpQTokGh3y272PzwUkdmS2N@mail.gmail.com>
	<AANLkTin8hwsKv1oZf1Tv_F97hZEVy=T=KzMcPSsn-O8r@domain.hid>
	<1304262109.2063.4.camel@domain.hid>
Date: Mon, 2 May 2011 10:58:44 +0200
Message-ID: <BANLkTikvUkLKJ0fybCjxXBP82GkiNPdAWw@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: multipart/mixed; boundary=0050450145d228907f04a2473bf9
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Andreas Glatz <andi.glatz@domain.hid>, xenomai@xenomai.org

--0050450145d228907f04a2473bf9
Content-Type: text/plain; charset=ISO-8859-1

Hi Philippe,

Thanks for the patch! Unfortunately this does not resolve the 'stuck
in primary of prio 0 after rt_task_send'.

I'll attach the basic test application that reproduces it. All prints
should contain secondary mode because all tasks are prio 0 and the
auto-relax patches are compiled in.

The producer which does the rt_task_send() call does not auto-relax to
secondary mode.

Thanks,
Henri.

On Sun, May 1, 2011 at 5:01 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Mon, 2011-03-28 at 12:56 +0200, Henri Roosen wrote:
>> Hi,
>>
>> We are using the back-ported auto-relax patches of Xenomai-head on the
>> 2.5.6 release on Linux 2.6.32.15.
>>
>> We noticed that our prio-0 shadowed task is not always auto-relaxed
>> and traced it back to a problem with rt_task_send/receive/reply. The
>> rt_task_send/receive/reply mechanism uses the xnsynch primitive to
>> implement its PIP. However, this mechanism only acquires the xysynch
>> primitive without releasing it. This results in the resource counter
>> never be 0 anymore and thus breaking the auto-relaxed which is based
>> on this resource counter.
>>
>> I guess releasing the xnsynch resets the owner, which is not wanted either..
>> Any idea for a fix?
>
> Could you give a try at this one? TIA,
> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=becb13774ab687d016857f6a972f4124fbd10c44
>
>>
>> Thanks,
>> Henri.
>>
>>
>> On Tue, Oct 12, 2010 at 9:16 AM, Henri Roosen <henriroosen@domain.hid> wrote:
>> > That was a problem with our build environment.
>> >
>> > Patches work and the base-prio 0 task nicely switches to the Linux
>> > domain and competes with the Linux threads for the processor. Now we
>> > don't loose TCP connection to our target anymore.
>> >
>> > Thanks!
>> >
>> > Henri
>> >
>> > On Mon, Oct 11, 2010 at 5:35 PM, Henri Roosen <henriroosen@domain.hid> wrote:
>> >> Thanks for the patches Philippe. I applied them to xenomai 2.5.5.
>> >> Tests with a basic application look good, however our bigger project
>> >> doesn't. I checked already if we release all mutexes; the base prio 0
>> >> thread thread released all of them but stays in primary domain after a
>> >> xenomai call.
>> >>
>> >> I'll setup a clean environment, just to be sure, and will investigate
>> >> further tomorrow.
>> >>
>> >> On Mon, Oct 11, 2010 at 11:31 AM, Andreas Glatz <andi.glatz@domain.hid> wrote:
>> >>>
>> >>>>
>> >>>> The auto-relax feature is now available from -head (upcoming
>> >>>> 2.6.x). You
>> >>>> will need all commits from
>> >>>> http://git.xenomai.org/?p=xenomai-
>> >>>> head.git;a=commit;h=b75cec19387e561f82ac55595db8c993b049f071
>> >>>> to
>> >>>> http://git.xenomai.org/?p=xenomai-
>> >>>> head.git;a=commit;h=6653a9e8eb7339b749989bd74adc3ac3bd29e4da
>> >>>>
>> >>>> --
>> >>>> Philippe.
>> >>>>
>> >>>>
>> >>>
>> >>> Very nice. Will try it out soon on my G4 PB Aluminium.
>> >>>
>> >>> Andreas
>> >>>
>> >>>
>> >>> _______________________________________________
>> >>> Xenomai-help mailing list
>> >>> Xenomai-help@domain.hid
>> >>> https://mail.gna.org/listinfo/xenomai-help
>> >>>
>> >>
>> >
>
> --
> Philippe.
>
>
>

--0050450145d228907f04a2473bf9
Content-Type: text/x-csrc; charset=US-ASCII; name="test_autorelax_tasksend.c"
Content-Disposition: attachment; filename="test_autorelax_tasksend.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gn76ht8c0

I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8dW5pc3Rk
Lmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPG5hdGl2ZS90YXNrLmg+CiNpbmNsdWRl
IDxuYXRpdmUvcXVldWUuaD4KI2luY2x1ZGUgPGFzbS1nZW5lcmljL3hlbm9tYWkvYml0cy9jdXJy
ZW50Lmg+CgojZGVmaW5lIENPTlNVTUVSX1RBU0tfUFJJICAgIDAKI2RlZmluZSBDT05TVU1FUl9T
VEFDS19TSVpFICA4MTkyCgojZGVmaW5lIFBST0RVQ0VSX1RBU0tfUFJJICAgIDAKI2RlZmluZSBQ
Uk9EVUNFUl9TVEFDS19TSVpFICA4MTkyCgojZGVmaW5lIENPTlNVTUVSX1dBSVQgMTUwCiNkZWZp
bmUgUFJPRFVDRVJfVFJJRyA0MAoKI2RlZmluZSBNQVhfU1RSSU5HX0xFTiA0MAoKc3RhdGljIGNv
bnN0IGNoYXIgKnNhdGNoX3NfdHVuZXNbXSA9IHsKICAgICJTdXJmaW5nIFdpdGggVGhlIEFsaWVu
IiwKICAgICJMb3JkcyBvZiBLYXJtYSIsCiAgICAiQmFuYW5hIE1hbmdvIiwKICAgICJQc3ljaG8g
TW9ua2V5IiwKICAgICJMdW1pbm91cyBGbGVzaCBHaWFudHMiLAogICAgIk1vcm9jY2FuIFN1bnNl
dCIsCiAgICAiU2F0Y2ggQm9vZ2llIiwKICAgICJGbHlpbmcgSW4gQSBCbHVlIERyZWFtIiwKICAg
ICJSaWRlIiwKICAgICJTdW1tZXIgU29uZyIsCiAgICAiU3BlZWQgT2YgTGlnaHQiLAogICAgIkNy
eXN0YWwgUGxhbmV0IiwKICAgICJSYXNwYmVycnkgSmFtIERlbHRhLVYiLAogICAgIkNoYW1wYWdu
ZT8iLAogICAgIkNsb3VkcyBSYWNlIEFjcm9zcyBUaGUgU2t5IiwKICAgICJFbmdpbmVzIE9mIENy
ZWF0aW9uIgp9OwoKc3RhdGljIFJUX1RBU0sgcHJvZHVjZXJfdGFzaywKCSAgICAgICBjb25zdW1l
cl90YXNrOwoKdm9pZCBjb25zdW1lcih2b2lkICpjb29raWUpCnsKICAgIGNoYXIgYnVmW01BWF9T
VFJJTkdfTEVOXTsKICAgIFJUX1RBU0tfTUNCIG1jYjsKICAgIGludCBmbG93aWQ7CiAgICBpbnQg
bW9kZTsKCiAgICBmb3IgKDs7KQoJewoJcnRfdGFza19zbGVlcChDT05TVU1FUl9XQUlUKTsKCglm
b3IgKDs7KQoJICAgIHsKCSAgICBtY2Iub3Bjb2RlID0gMDsJLyogRHVtbXkuICovCgkgICAgbWNi
LmRhdGEgPSAoY2FkZHJfdClidWY7CgkgICAgbWNiLnNpemUgPSBzaXplb2YoYnVmKTsKCSAgICBm
bG93aWQgPSBydF90YXNrX3JlY2VpdmUoJm1jYixUTV9OT05CTE9DSyk7CiAgICAgICAgICAgIG1v
ZGUgPSB4ZW5vX2dldF9jdXJyZW50X21vZGUoKTsKCSAgICBpZiAoZmxvd2lkIDwgMCkKCQlicmVh
azsKCgkgICAgcHJpbnRmKCJOb3cgcGxheWluZyAlcy4uLiBpbiAlcyBtb2RlLlxuIixidWYsICht
b2RlICYgWE5SRUxBWCkgPyAic2Vjb25kYXJ5IiA6ICJwcmltYXJ5Iik7CgkgICAgcnRfdGFza19y
ZXBseShmbG93aWQsTlVMTCk7CgkgICAgfQoJfQp9Cgp2b2lkIHByb2R1Y2VyKHZvaWQgKmNvb2tp
ZSkKewogICAgaW50IG5leHRfbXNnID0gMDsKICAgIFJUX1RBU0tfTUNCIG1jYjsKICAgIGNvbnN0
IGNoYXIgKm1zZzsKICAgIGludCBtb2RlOwoKICAgIGZvciAoOzspCgl7CglydF90YXNrX3NsZWVw
KFBST0RVQ0VSX1RSSUcpOwoKCW1zZyA9IHNhdGNoX3NfdHVuZXNbbmV4dF9tc2crK107CgluZXh0
X21zZyAlPSAoc2l6ZW9mKHNhdGNoX3NfdHVuZXMpIC8gc2l6ZW9mKHNhdGNoX3NfdHVuZXNbMF0p
KTsKCgltY2Iub3Bjb2RlID0gMDsJLyogRHVtbXkuICovCgltY2IuZGF0YSA9IChjYWRkcl90KW1z
ZzsKCW1jYi5zaXplID0gc3RybGVuKG1zZykgKyAxOyAvKiBcMCBtdXN0IGJlIGNvcGllZC4gKi8K
CXJ0X3Rhc2tfc2VuZCgmY29uc3VtZXJfdGFzaywmbWNiLE5VTEwsVE1fSU5GSU5JVEUpOwoJbW9k
ZSA9IHhlbm9fZ2V0X2N1cnJlbnRfbW9kZSgpOwogICAgICAgIHByaW50ZigiUHJvZHVjZXIgbW9k
ZSAlc1xuIiwgKG1vZGUgJiBYTlJFTEFYKSA/ICJzZWNvbmRhcnkiIDogInByaW1hcnkiKTsKCX0K
fQoKaW50IG1haW4odm9pZCkKewogICAgbWxvY2thbGwoTUNMX0NVUlJFTlQgfCBNQ0xfRlVUVVJF
KTsKICAgIHJ0X3RpbWVyX3NldF9tb2RlKDEwMDAwMDApOwkvKiBGb3JjIDFtcyBwZXJpb2RpYyB0
aWNrLiAqLwoKICAgIHJ0X3Rhc2tfc3Bhd24oJmNvbnN1bWVyX3Rhc2ssCgkJICAiQ29uc3VtZXJU
YXNrIiwKCQkgIENPTlNVTUVSX1NUQUNLX1NJWkUsCgkJICBDT05TVU1FUl9UQVNLX1BSSSwKCQkg
IDAsCgkJICAmY29uc3VtZXIsCgkJICBOVUxMKTsKCiAgICBydF90YXNrX3NwYXduKCZwcm9kdWNl
cl90YXNrLAoJCSAgIlByb2R1Y2VyVGFzayIsCgkJICBQUk9EVUNFUl9TVEFDS19TSVpFLAoJCSAg
UFJPRFVDRVJfVEFTS19QUkksCgkJICAwLAoJCSAgJnByb2R1Y2VyLAoJCSAgTlVMTCk7CiAgICB3
aGlsZSAoMSk7CiAgICByZXR1cm4gMDsKfQoK
--0050450145d228907f04a2473bf9--

