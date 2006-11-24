Message-ID: <456708F7.3040406@domain.hid>
Date: Fri, 24 Nov 2006 16:00:07 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN update, please read
References: <4566F619.9060403@domain.hid> <4566F934.9070905@domain.hid>
In-Reply-To: <4566F934.9070905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> I have just commited various modifications and improvements for
>> RT-Socket-CAN to the SVN trunk (v2.3-devel). The modification you might
>> realize sooner than later is the renaming of the RT-Socket-CAN kernel
>> modules from "xeno_rtcan_*" to "xeno_can_*" to comply with the usual
>> RTDM driver naming scheme. I have attached the full ChangeLog entry.
> 
> One wish for the future: if possible, please try to break up such large
> commits into smaller pieces. They should be compilable on their own in
> order to hunt potential issues (also with the help of users) on a more
> fine-grained base by switching back and forth svn revisions. quilt can
> help to manage such pieces, I'm using it even for private stuff.

I know, I agree, but it makes more work and testing takes more time and 
"free" time" is rare :-(. Nevertheless, I did not change fundamental or 
critical things.

Wolfgang.


