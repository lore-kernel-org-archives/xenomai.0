Message-Id: <s52e5054.066@domain.hid>
Date: Thu, 12 Oct 2006 14:25:06 +0200
From: "Marc LE DOUARAIN" <m.ledouarain@domain.hid>
Subject: =?ISO-8859-1?Q?R=E9p.=20:=20Re:=20[Xenomai-help]=20collection=20?=
	=?ISO-8859-1?Q?of=20example?=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org



>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> 11.10 10:31
>>>
>Pavel Pirkl wrote:
>> Hello,
>> I am a novice in using of RTOS Xenomai.
>> 
>> 
>> 2.
>> Now I am using Linux distribution Slackware and Xenomai.
>> But I need to find some minidistribution for booting from
CompactFlash 
>> disk.
>> And I need to stop written to this CompactFlash so all programs must
to 
>> run from RAM memory.
>> Can you help me? I hear about ELinOS and free licence?
>
>There are several distributions for embedded systems, see
>http://www.linuxdevices.com/articles/AT2760742655.html 
>
>-- 

Another mini-distribution (White Dwarf Linux) is available here : 
http://www.blast.com/index.php?id=35 

To avoid writing to your compact flash, you can mount the root in
read-only (option to pass to lilo/grub)
And have a ram-disk that will be mounted to /var where you have some
files that can be written (not sure that it is enough...)

Bye.



