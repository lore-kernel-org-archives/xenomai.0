MIME-Version: 1.0
In-Reply-To: <1241714598.26544.733.camel@domain.hid>
References: <24870972-4150-4835-9564-0ED960A6FD44@domain.hid>
	<1241714598.26544.733.camel@domain.hid>
Date: Fri, 15 May 2009 09:24:02 -0400
Message-ID: <b6ad4ed70905150624h5d611ee3sc7c59098b59e3045@domain.hid>
From: John Yamokoski <yamokosk@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Desktop randomly freezes after install of
	Xenomai 2.4.7
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, adeos-main <adeos-main@gna.org>

Just to follow up, I used the newer kernel patch (along with the newer
kernel) and also disabled those two options you all mentioned and now
the system seems to be running just fine.

Thanks for your help,

J.D.

On Thu, May 7, 2009 at 12:43 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Thu, 2009-05-07 at 12:36 -0400, John Yamokoski wrote:
>> Since my freezing problems may not be related to other people's
>> freezing problems I have started a new thread.
>>
>
> Good.
>
>> I compiled/installed/ran kernel 2.6.28.7 using the standard install
>> procedure for Xenomai 2.4.7. I have not yet compiled and installed the
>> xenomai user libraries nor am I running any custom code which is
>> making real-time calls. The desktop just seems to freeze at very
>> random times. Can happen when the desktop is just beginning to
>> populate or much later after the desktop has been running for several
>> minutes. I tried to catch some diagnostic information using netconsole
>> but I don't get any messages when the computer freezes. Attached are a
>> netconsole dump as well as my .config from the kernel compile.
>
> Please try this patch, instead of the one shipped with vanilla 2.4.7:
> http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.28.9-x86-2.2-07.patch
>
>>
>> _______________________________________________ Xenomai-help mailing list Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help
> --
> Philippe.
>
>
>

