Subject: Re: cc1: error: code model kernel does not support PIC mode
References: <2092994816.180587.1635929129115.ref@mail.yahoo.com>
 <2092994816.180587.1635929129115@mail.yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f1eb24f1-c069-312f-8938-4563c6a0a566@siemens.com>
Date: Wed, 3 Nov 2021 09:55:26 +0100
MIME-Version: 1.0
In-Reply-To: <2092994816.180587.1635929129115@mail.yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: zared kamal <zaredkam@yahoo.fr>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.11.21 09:45, zared kamal via Xenomai wrote:
> dear sir,sources: 
> xenomai 3.0.8
> linux-4.1.18ipipe-4.1.18
> i try to compile the kernel with command make && make moules_install installbut i get the error 
> [sudo] password for sicom3: 
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CC      kernel/bounds.s
> cc1: error: code model kernel does not support PIC mode
> Kbuild:43: recipe for target 'kernel/bounds.s' failed
> make[1]: *** [kernel/bounds.s] Error 1
> Makefile:990: recipe for target 'prepare0' failed
> make: *** [prepare0] Error 2
> 

4.1 is long dead. What prevents you from using a currently supported
kernel and Xenomai version? BTW, your Xenomai release is not latest in
its stable series as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

