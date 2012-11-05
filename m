Message-ID: <5097E223.4020600@gmail.com>
Date: Mon, 05 Nov 2012 15:58:27 +0000
From: Stefan Videv <videvstefan@gmail.com>
MIME-Version: 1.0
References: <a81ced276a31df626d584233b83aeb10.squirrel@www.xenomai.org>
	<5092AEB3.2070009@gmail.com>
	<4b27818deb6c26a74a2ab839cb07f718.squirrel@www.xenomai.org>
	<5093F975.9060807@gmail.com>
	<d0e366dc91d7b37cd45f8b3a550ea2fd.squirrel@www.xenomai.org>
	<5094066F.80501@gmail.com>
	<6f7c3c10f83647f48c380d2fa64b22c1.squirrel@www.xenomai.org>
	<509409BF.3060808@gmail.com>
	<9057373f4f1063cc464eccb857ac7992.squirrel@www.xenomai.org>
In-Reply-To: <9057373f4f1063cc464eccb857ac7992.squirrel@www.xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compiling the Xenomai examples
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 11/02/2012 06:46 PM, Gilles Chanteperdrix wrote:
> Stefan Videv wrote:
>> Thanks. I got it to compile now -- I pointed to the root directory of
>> the kernel sources, is that ok? It of course remains to be tested if the
>> examples would work at all. Do you want me to let you guys know when I
>> test that?
> Yes, please.
>
Okay, so I've tested the examples I compiled last week.

-- common: could not test as I don't have the particular hardware required
-- native: work
-- posix: fails to load the kernel module with:
     satch: Unknown symbol munmap (err 0)
     satch: Unknown symbol shm_open (err 0)
     satch: Unknown symbol pse51_shm_close (err 0)
     satch: Unknown symbol ftruncate (err 0)
     satch: Unknown symbol mmap (err 0)
     satch: Unknown symbol shm_unlink (err 0)
-- rtdm driver-api -- works, the second example seems to be out of date 
with the xenomai API as I get a message saying RT open and close 
handlers are deprecated.
-- rtdm profiles -- could/did not test

Any ideas regarding the problem with the POSIX example kernel module?

-- Stefan


