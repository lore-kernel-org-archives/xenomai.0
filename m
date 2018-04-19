References: <C2EC5BA46D13CD44B5915A8FEEB4C44E8488E31A@DDCEXCH.ddc-ny.com>
 <2fa46484-f8e1-ffbd-5e67-79d6345d08d2@xenomai.org>
 <C2EC5BA46D13CD44B5915A8FEEB4C44E8489E1E1@DDCEXCH.ddc-ny.com>
 <b72099ab-d43f-ae57-7cea-fa801cd98d1c@xenomai.org>
 <C2EC5BA46D13CD44B5915A8FEEB4C44E8489E20B@DDCEXCH.ddc-ny.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5d7e35c2-dde2-e44b-dc7e-d073570b6661@xenomai.org>
Date: Thu, 19 Apr 2018 09:26:29 +0200
MIME-Version: 1.0
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44E8489E20B@DDCEXCH.ddc-ny.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] mmap when using in conjunction with mapper to
 retrieve memory mapped IO space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>

On 04/19/2018 01:02 AM, Pham, Phong wrote:
> “This is likely happening because the default auto-init glue module for
> a final executable is mentioned in the flags, you either want to pass
> --auto-init-solib if you do need auto-init for bootstrapping a DSO, or
> --no-auto-init if you don't care about auto-bootstrap, along with
> --ldflags to xeno-config.
> 
>  
> 
> http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html“
> 
>  
> 
>  
> 
> I see.  After adding either --auto-init-solib or --no-auto-init when
> compiling for library, along with compiler option -fPIC, mmap() still
> returns -1; (W/out -fPIC, munmap() cannot be relocated (similar types of
> error like before).

xeno-config --ldflags will return the Xenomai-related flags for linking,
which -fPIC is not. If you plan for building a DSO, you need to apply
the common rules stated in the ld documentation, which include
mentioning  -fPIC / -fpic for shared libs. This is not a Xenomai issue.

  However, errno is 0.  How come errno returns “no
> error” when mmap() returns failure?
> 

Please post a test code snippet illustrating the problem.

-- 
Philippe.

