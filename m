Message-ID: <518BD2BF.3040801@xenomai.org>
Date: Thu, 09 May 2013 18:45:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>	<CAPpP=rNCxHUfcBS7djmv8i+Er2PpXBdO101LfcxaZswzc9eBnw@mail.gmail.com>	<518BAF44.9060803@xenomai.org>	<CAPpP=rMLPeRAVCpdKQkLVD29pFUj8zPL5JRmTbrJkKEetJJbew@mail.gmail.com>	<CAPpP=rM6BTevvfoV+TT4ej6zkeyzdnY7yN_qVCUPkLFe38EUYA@mail.gmail.com>	<518BB895.3050208@xenomai.org>	<CAPpP=rNFf4qH0JPpR57i5qp1tmHbLb2k8X9qYjn+6dmZb_ckvA@mail.gmail.com>	<518BBFDC.7060102@xenomai.org>	<CAPpP=rOFw32ctFaLGtrPd-L0ZaTR_d38HhLZ9anSrk1tucv-xw@mail.gmail.com>	<518BC2C3.3080004@xenomai.org>	<CAPpP=rNCqAAiAzTviRxk7Oy1MRO4A6VGk5cJKVSGSa9q_Xp+Fg@mail.gmail.com>	<518BC59F.60208@xenomai.org>	<CAPpP=rPFd3h_aTBKoL6bUwAqbLT5yDp0G057h1PssUo8MVKxDg@mail.gmail.com>	<518BCB6B.5070908@xenomai.org>	<CAPpP=rNs37xZRsJRd3JvS4Pf16jhRWmxsS+Y6gVR=R9RQ6SWjQ@mail.gmail.com>	<518BCD6C.8060501@xenomai.org>	<CAPpP=rODvDuVjP+CfE=6jYTRP5nD5smumnAV3mj51YQm8mzw0Q@mail.gmail.com>
	<CAPpP=rP1qoFzTHimu3hZA7fcR3dCqfQXYOKUpfsK__3pUPMB8A@mail.gmail.com>
In-Reply-To: <CAPpP=rP1qoFzTHimu3hZA7fcR3dCqfQXYOKUpfsK__3pUPMB8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/09/2013 06:44 PM, alex alex wrote:

> vmlinuz is a zImage, or bzImage, we are interested in vmlinux, the ELF
> 
>> image you get when compiling the kernel, at the top of the build tree.
>>
>>
> I had no longer the vmlinux file so I have extract the vmlinuz from the
> /boot directory with "linux-headers-3.5.7-xenomai/
> scripts/extract-vmlinux" now I have a vmlinux file but I there are only
> assembly code like that :
> 
> 
> ....
> 
> c107eb4c:    8d 74 26 00              lea    0x0(%esi,%eiz,1),%esi
> c107eb50:    55                       push   %ebp
> c107eb51:    89 e5                    mov    %esp,%ebp
> c107eb53:    57                       push   %edi
> c107eb54:    56                       push   %esi
> c107eb55:    53                       push   %ebx
> c107eb56:    83 ec 10                 sub    $0x10,%esp
> c107eb59:    e8 6a a9 59 00           call   0xc16194c8
> c107eb5e:    8b 1d 6c 58 9f c1        mov    0xc19f586c,%ebx
> c107eb64:    89 45 e4                 mov    %eax,-0x1c(%ebp


please put the vmlinux file on an ftp or http server somewhere.


-- 
                                                                Gilles.

