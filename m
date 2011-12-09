Message-ID: <4EE26B2A.1040702@domain.hid>
Date: Fri, 09 Dec 2011 21:10:18 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4ED66FD7.4010403@domain.hid> <4EE20EA4.6080305@domain.hid>
	<4EE22E83.6050406@domain.hid>
In-Reply-To: <4EE22E83.6050406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Analogy/mite
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/09/2011 04:51 PM, Anders Blomdell wrote:
> On 12/09/2011 02:35 PM, Anders Blomdell wrote:
>> On 11/30/2011 07:03 PM, Anders Blomdell wrote:
>>> Hi, just found that
>>>
>>> echo 0000:06:01.0 > /sys/bus/pci/drivers/analogy_mite/unbind
>>>
>>> does not do the same thing as
>>>
>>> analogy_config -r analogyN
>>>
>>> in fact it leaves the system in a state where using the driver results
>>> in a kernel OOPS.
>>>
>>> Will try to look into it further tomorrow...
>> Well, took quite some time to track down the 'analogy_config -r' bug
>> (which was responsible for the kernel OOPS [i.e. after fixing it I have
>> not got any OOPSes]).
>>
>> So back to the original problem, does anybody foresee that a call to
>> a4l_ioctl_devcfg(cxt, NULL) from the mite driver would give any problems
>> (apart from getting the context pointer from the data structures the
>> mite driver has handy)? It is probably not kosher to do ioctl on a
>> driver that is not open, but...
> Attached is a hack (as can be gleaned from the EXPORT_SYMBOL_GPL), if
> the basic assumption that it's ok to do a a4l_ioctl_devcfg(...) during
> unbind, I could rewrite the logic to pass down a pointer to
> a4l_ioctl_devcfg to avoid this.

Sloppy me, should of course be:
 >+	if (mite->a4ldev) {
	if (mite->a4ldev && mite->a4ldev->cxt) {
 >+		a4l_ioctl_devcfg(mite->a4ldev->cxt, NULL);
 >+			}


