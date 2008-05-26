Message-ID: <483ADD27.2080203@domain.hid>
Date: Mon, 26 May 2008 17:54:15 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <483ADAE3.2060105@domain.hid>
	<2ff1a98a0805260848gd2f8badg97f10483242c9e45@domain.hid>
In-Reply-To: <2ff1a98a0805260848gd2f8badg97f10483242c9e45@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] revision 3882 breaks compilation of xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On Mon, May 26, 2008 at 5:44 PM, Sebastian Smolorz
> <smolorz@domain.hid> wrote:
>> Hello Gilles,
>>
>> with your last commit:
>> Fix compilation with ucLibc
>>
>> I cannot build xenomai userland any more (at least when taking glibc).
>> cyclictest fails with the following error:
>>
>> ../../skins/posix/.libs/libpthread_rt.so: undefined reference to `likely'
>> ../../skins/posix/.libs/libpthread_rt.so: undefined reference to `unlikely'
>> collect2: ld returned 1 exit status
> 
> Ok. Could you try to add a #include <nucleus/compiler.h> in
> ksrc/skins/posix/cb_lock.h ?

Yes, that solves it.

-- 
Sebastian

