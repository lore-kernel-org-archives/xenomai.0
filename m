From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <49FB943E.8060502@domain.hid>
References: <49FB943E.8060502@domain.hid>
Content-Type: text/plain
Date: Sat, 02 May 2009 18:09:44 +0200
Message-Id: <1241280584.26544.231.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] TLB patches for 2.6.26
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Thomas Lockhart <Thomas.Lockhart@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2009-05-01 at 17:30 -0700, Thomas Lockhart wrote:
> I've got patches applying the recent mods in tlb_32.c and tlb_64.c to a 
> 2.6.26 kernel. My full patch file is for 2.6.26.8 and mentions the same 
> number of files as does the one for 2.6.26.7 in the 2.4.7 Xenomai tree. 
> The file is around 330kb uncompressed and 62kb compressed, so I've 
> included the compressed version here.
> 
> I'd expect the patch file to apply to 2.6.26.7 with one or two files 
> showing slight offsets (that was the case applying 2.6.26.7 patches to 
> my 2.6.26.8 tree).
> 
> I wasn't sure about the proper naming convention for the file and 
> omitted the last couple of fields found in the existing patch files.
> 

Thanks. Now rebased on 2.0-17, and available from:
http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.26.8-x86-2.0-18.patch

>                                                - Tom
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



