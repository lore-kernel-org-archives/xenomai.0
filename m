Message-ID: <4DF9CA8B.8070304@domain.hid>
Date: Thu, 16 Jun 2011 10:19:07 +0100
From: Jakub Nowacki <j.s.nowacki@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

On 16 June 2011 09:52, Pavel Machek <pma@domain.hid> wrote:
>
>> that. I have SMI workaround switched on. On the other hand I have
>> MSI enabled (because I cannot disable them in *config) and Legacy
>> USB in BIOS, because, for some reason, my USB keyboard doesn't work
>> in grub without it (I cannot select anything in grub but it works
>> later in the system correctly).
>
> This may be well it.
>
> GRUB tries to access keyboard controller (it does not have a USB
> support), thus you need "Legacy USB" in BIOS. Linux can handle USB and
> does not need it.
>
> Get PS/2 keyboard for an experiment...

Thanks for clarifying that. The problem with Intel's Q57 and other new
motherboards I've seen recently is that they do not have PS/2 (I've
got even the adaptor with the keyboard but there is just no place to
plug it in).

