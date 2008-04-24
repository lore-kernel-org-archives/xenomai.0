Message-ID: <48105D6F.8040603@domain.hid>
Date: Thu, 24 Apr 2008 12:14:07 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4810488D.9030909@domain.hid>
	<27116705.1209018431019.JavaMail.ngmail@domain.hid>
	<31638452.1209029143484.JavaMail.ngmail@domain.hid>
In-Reply-To: <31638452.1209029143484.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Current state of RTDM-native?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

M. Koehrer wrote:
> Hello Wolfgang, 
> 
>> I do not know of any activities, but it should not be a big effort to
>> get RTnet ported over RTDM-native. As I see it, mainly the build system
>> of RTnet needs adaption.
>>
> thanks for your response. That sounds very good.
> I can remember, that a long while ago, the interrupt handling was not realized yet with rtdm-native
> which is necessary to get rtnet up and running.
> Is this implemented now?

I'm not sure what you mean. RTDM-native has been tested with
RT-Socket-CAN, which uses interrupts, of course.

While reading my old README

http://svn.gna.org/viewcvs/xenomai/branches/rtdm-native/README.rtdm-native?rev=2386&view=auto

I now remember some more quirks, especially with tasks termination,
which might be problematic with RTnet. Maybe a RTDM port over
Xenomai-Solo would be more straight forward, but that's another project.

Wolfgang.

