Date: Fri, 27 Aug 2021 10:31:09 -0400
Subject: Re: autotune inside qemu: early shot and segfault
Message-ID: <20210827143109.GC6676@csclub.uwaterloo.ca>
References: <42504023-fcfb-7f38-e806-0c41793adb9d@siemens.com>
 <fee7159e-85d5-bffc-fd89-79050166d080@siemens.com>
 <6c8843f98aea5786d95f57d46cbaf0f2ec267951.camel@siemens.com>
 <da4bf683-2a3d-5e32-e4aa-bd9ecef0a605@siemens.com>
 <09ace02a61b9e1c30e4c6dab4170a115e064576a.camel@siemens.com>
 <6a53e808-af45-e68b-ca8e-e210d7af8391@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a53e808-af45-e68b-ca8e-e210d7af8391@siemens.com>
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Aug 27, 2021 at 02:15:29PM +0200, Jan Kiszka via Xenomai wrote:
> On 27.08.21 13:39, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> > Wow, once coredumpctl was installed I got:
> > 
> > Stack trace of thread 312:
> >                 #0  0x00000000b6f50daa _Unwind_VRS_Pop (libgcc_s.so.1)
> > 
> > Compiler issue? I'm currently using
> > gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> > 
> 
> Wait: You have a Debian 10 where (gcc is gcc-8), but for this test you
> built autotune (only that?) with gcc-10?

Debian 11 uses gcc 10.2.1.  The version says "Debian 10.2.1-6) meaning
gcc version is debian package version 10.2.1-6.  It would certainly be
Debian 11.

-- 
Len Sorensen

