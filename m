Date: Thu, 3 May 2007 09:05:37 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
In-Reply-To: <4638A574.5020706@domain.hid>
Message-ID: <Pine.LNX.4.64.0705030901250.31536@domain.hid>
References: <46388DCC.5070303@domain.hid> <46389325.7080200@domain.hid>
	<4638A368.9040705@domain.hid> <4638A574.5020706@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] HELP!!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

On Wed, 2 May 2007, Jan Kiszka wrote:
[...]
>>> But note in advance that RTnet for I/O coupling requires RTnet I/O
>>> coupler that you cannot buy as there are no commercial ones. You would
>>> have to embed it on your own. Maybe you then rather want to use the
>>> Ethercat MasterLibrary with RTnet to attach Ethercat I/O nodes.
>>
>> This looks like it may be a break. I had just found ethercat before this
>> mail came in. By the look of things (very early) the hardware (Beckhoff)
>> will give the IO and according to the vendor (who I have limited faith
>> in by now) should make the time.
>>
>> But my next problem will be to get xenomai to work with ethercat. You
>> say I can try using the Ethercat Master library with RTnet. But why
>> would I need RTnet? How will the layering look in this case? IOW what
>> functionality will the ethernet master library provide and what will the
>> RTnet provide?
>>
>> Has anyone done this before?

We did.  We used it to drive a 2-dof table.

> [being in a hurry]
> Check the links on www.rtnet.org to the related project at FMTC. They
> even have mailing lists for detail questions.
>
> The setup will be: Xenomai (basis) + RTnet (RT-NIC driver, core network
> stack) + EML (userspace lib with Ethercat master code) + Your App
> (linked against Xenomai and EML).

<http://www.mail-archive.com/rtnet-users@domain.hid>

Klaas

