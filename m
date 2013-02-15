Message-ID: <511E532C.2010209@mediso.hu>
Date: Fri, 15 Feb 2013 16:24:28 +0100
From: Norbert Bukuli <norbert.bukuli@mediso.hu>
MIME-Version: 1.0
References: <511B94E4.2070708@mediso.hu> <511B9901.7040104@xenomai.org>
	<511BB60E.7090900@mediso.hu> <511BCA3E.4050705@xenomai.org>
	<511C989C.7070700@mediso.hu> <511E2846.8040206@xenomai.org>
	<511E38CD.8080301@mediso.hu> <511E4B65.5040403@xenomai.org>
In-Reply-To: <511E4B65.5040403@xenomai.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Floating point operations in kernel on powerpc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 2013-02-15 15:51, Philippe Gerum wrote:
> On 02/15/2013 02:31 PM, Norbert Bukuli wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> Thank you again for your kind help! I am really sorry for the
>> confusing question. Now we are compiling kernel modules only.
>> Afterwards we port our application from RTAI, kernelspace to
>> Xenomai, kernelspace will we port from kernelspace to userspace. 
>> I found what makes the problem. The CONFIG_CC_OPTIMIZE_FOR_SIZE
>> kernel option was set on. After I turned it off, the compilation
>> was successful.
> 
> I guess you are referring to that issue brought in by gcc releases
> >= 4.4.x? 
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg17189.html
>
> 
http://gcc.gnu.org/ml/gcc-patches/2008-04/msg01678.html
> 
Yes, that was the problem, definitely.

> It looks like the suggested kernel patch to fix it did not make its
> way to the kernel. Bottom line is that it's not fpu related
> actually. This is definitely good material for the Xenomai wiki.
> 

- -- 
Best regards,
Norbert Bukuli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRHlMsAAoJEJEs22zQJ00Su18IALszpx85WwK8kR7U/kgRg9ex
Y4Fod11O+erU/dRpAwVhvxK8mK+HO06m0GARAadkDUjQJjFmjOUyEs6p71oFGRkQ
+l6/IJOnUCVOjOVO5JLhYjsyoeh8VnQtMcI9IUIvoukSNPngyr41UMOTFp7traXj
Mdnjbt2Spk8CY3u2JX28SbfzEjSBmmnQajTJy9mOtkrpXyRt4D6Pbsyb4M1gVD5N
LbCX09/Vj6B9yJrWk1bvKxm7Lbbin2O896k/tTTh5ZxH0HyS9ZnTLrKKDWN65ZMq
sJZg84cN23U8vv3WJVwhdRmXvZ8ub8eLjM9R1gmK89F7v4+Arwsou8VQv2EBbjY=
=yprj
-----END PGP SIGNATURE-----

