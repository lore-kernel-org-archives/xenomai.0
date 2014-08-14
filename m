Message-ID: <53ED39DC.5030504@xenomai.org>
Date: Thu, 14 Aug 2014 18:36:12 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAEGbdidABiixUba3TiheYcLx1Swh5TrTbt_FtenZsExq7weUYg@mail.gmail.com>
 <53E93A3D.2060403@nta-inc.net>
In-Reply-To: <53E93A3D.2060403@nta-inc.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] C++ std::thread and xenomai pthread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/11/2014 05:48 PM, Jeff Webb wrote:
> On 08/11/2014 10:33 AM, Matthew Lindner wrote:
>> Has anyone experimented with using std::thread from the C++ STL library? I
>> am curious if it automatically incorporates the xenomai pthread API layer
>> or whether it bypasses that and accesses the linux pthread library.
> 
> Yes, I've tried this and it has worked for me.

some years ago I presented this at XUM 2009.
Some of the recommendations are no longer valid - user space drivers for instance
(this project was before RTDM) - but we did use Xenomai to successfully deploy a
large scale C++ software project.
http://www.denx.de/en/pub/News/Xum2009AbstractsAndPresentations/Xenomai_and_Realtime_Image_Processing_Control.pdf

> 
> -Jeff
> 
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 

- -- 
jro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJT7TncAAoJECDcy2IJkagRueMH+wcbjUhimnPfFlPfXe+OgxiH
Xnwu0Bax8a2nV2u4OviuhcZlDtXcTuhtBpWrFu3Pp+RMfnI9nfnfg5cxIK3KfMCf
uNYjlSC2eo5XVfr3dOSfmZ+3CKfoZcwPVhEb5YZs47t5oZeZmi9eYlNEvQ3+DBMZ
Ai+LrFj8JcX9YDdvWz0C9t8jRXePSFK7UIjDU7HeCtmLFWnzQFHc80+ujdeANoBQ
LUf7JZXa1oQxqZE9Sh18YhMZQwmjc0PdLF8+nCQPGid2gfw90C379G9SMl3RPvhT
IhiSUybNpOEM2aeRnCg0IpITx/pgjQIn3Tbjv+UA3RiJ0UvkHp4AOGP46EkCF4A=
=yhLV
-----END PGP SIGNATURE-----

