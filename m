From: "Peter Hua" <Phua@domain.hid>
Date: Tue, 17 Jan 2012 10:11:30 -0800
Message-ID: <004a01ccd543$701066f0$503134d0$@innovative-dsp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: [Xenomai-help] rt context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Thank you, Philippe.  This issue is resolved.  One follow-on question: the
CSW field of /proc/Xenomai/stat indicates the number of switches between
user-mode and kernel-mode, correct?


Regards,
Peter





-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org] 
Sent: Tuesday, January 17, 2012 12:37 AM
To: Peter Hua
Cc: xenomai-help-owner@domain.hid
Subject: Re: help rejected

On 01/17/2012 02:06 AM, Peter Hua wrote:
> Hi Philippe,
>
> I retract my previous statement.  The call to rtdm_in_rt_context() 
> returned '1'.  So the task was in RT context, but I don't understand 
> how?  Is there a way to force it to be non-rt?

There is no way you can do that from kernel space; mode switches are
implemented during the syscall transition between user and kernel. 
Memory mapping operation is usually part of the init chores of a driver, in
which case this would be a non-issue since RTDM runs the .open call in
non-rt kernel context (.open_rt is deprecated and even removed in latest
versions).

If your code tries to issue this mapping call from .ioctl_rt, then you
should move this particular ioctl command to the .ioctl_nrt handler instead.
Xenomai first tries the .ioctl_rt handler if present, then downgrades to
.ioctl_nrt if the former returned -ENOSYS. So, if both .ioctl_rt and
.ioctl_nrt have to coexist in your driver, then you should follow this
pattern:

static int foo_ioctl_rt(struct rtdm_dev_context *context,
		     rtdm_user_info_t *user_info,
		     unsigned int cmd, void *arg)
{
	switch (cmd) {

	case IOC_WHATEVER_MMAP:
		/* Tell Xenomai to offload to _nrt handler. */
		return -ENOSYS;
	...
	}
}

static int foo_ioctl_rt(struct rtdm_dev_context *context,
		     rtdm_user_info_t *user_info,
		     unsigned int cmd, void *arg)
{
	switch (cmd) {

	case IOC_WHATEVER_MMAP:
		ret =rtdm_mmap_to_user(...);
	...
	}
}

PS: I see you are now subscribed to Xenomai-help, so you should be allowed
to post there.

>
>
> Regards,
> Peter
>
>
>
>
>
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Monday, January 16, 2012 1:53 PM
> To: Peter Hua
> Cc: xenomai-help-owner@domain.hid
> Subject: Re: help rejected
>
> On 01/16/2012 05:40 PM, Peter Hua wrote:
>>
>> Hello,
>>
>> My request for help was rejected.  Also, I did not get a confirmation 
>> for the subscription request.  Please help.
>
> I'll check your subscription asap, but for the time being, the answer 
> to your question is that you may not call that routine from a 
> real-time context. This is callable only from kernel module init, and 
> any other plain linux (kernel) context, not from Xenomai -rt context in
kernel space.
>
>>
>> Regards,
>> Peter
>>
>>
>>
>>
>> -----Original Message-----
>> From: xenomai-help-bounces@domain.hid
>> [mailto:xenomai-help-bounces@domain.hid] On Behalf Of 
>> xenomai-help-owner@domain.hid
>> Sent: Friday, January 13, 2012 12:17 PM
>> To: phua@domain.hid
>> Subject: rtdm_mmap_to_user call failed
>>
>> You are not allowed to post to this mailing list, and your message 
>> has been automatically rejected.  If you think that your messages are 
>> being rejected in error, contact the mailing list owner at
> xenomai-help-owner@domain.hid.
>>
>
>
> --
> Philippe.
>
>
>


--
Philippe.


