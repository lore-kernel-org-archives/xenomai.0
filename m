Message-ID: <2ff1a98a0805190557j743680d4sb7d9f5c8e97072e@domain.hid>
Date: Mon, 19 May 2008 14:57:04 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid>
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

On Mon, May 19, 2008 at 2:32 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Mon, May 19, 2008 at 2:14 PM, Fabien MAHOT
> <fabien.mahot@domain.hid> wrote:
>> Hello,
>>
>> I ve a problem with my software application. I use Linux kernel 2.6.23
>> patched Xenomai 2.4.2. My hardware is an ETX module with AMD Geode
>> Processor.
>>
>> I wrote a test program to explain my problem. This crashes my system and I
>> must reboot it. I think there is a bug when a thread calls Linux write
>> function and when in the same time, a signal is catched to indicate a
>> time-out end.

Also note that since real-time signals use Linux signals in
user-space, they cause the target thread to switch to secondary mode,
which means that it is no longer a real-time thread.

-- 
 Gilles

