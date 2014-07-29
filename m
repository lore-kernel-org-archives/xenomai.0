Message-ID: <53D7C9DE.5060907@xenomai.org>
Date: Tue, 29 Jul 2014 18:20:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <c0432fe8fb61494588e50b7c7cbf5b17@CVEX13.valentin-carl.de>
In-Reply-To: <c0432fe8fb61494588e50b7c7cbf5b17@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cross compiling include path
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/29/2014 03:59 PM, Reitinger, Peter wrote:
> Hi dear xenomai people,
> 
> sorry that I have so many question, but there is already another one... ;-)
> 
> I have seen that my output for cflags is as follows:
> 
> hico@debian:dimm-am335x:~/workspace/Xenomai/xenomai_from_git/staging_dir/usr/xenomai/bin$ xeno-config --skin=native --cflags
> -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> 
> But it should be -I${staging_dir}/usr/xenomai/include as I guess for cross compilation.
> Is it -I/usr... because I have made a mis-configuration in any step before? Of course, I can simply fix it by adapting my Makefile and add the right include directory, but I would like to prevent later problems as early as possible...

See:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags

The example is for the posix skin.

-- 
                                                                Gilles.

