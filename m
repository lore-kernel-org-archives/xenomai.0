Subject: Re: Building deb packages
References: <a6zvfTWG8HmL1m3CKsFlVVKFO4CznsabNKtz6u1vD1P4HVWcun3mWGHs11YE4exIKjC48U7t5383dTEbXZfYmMeFvHqNnrmzjp0izgkWFys=@codecraftsmen.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <378aee64-da86-da9f-eb46-5059949e37d7@siemens.com>
Date: Tue, 26 Nov 2019 18:45:35 +0100
MIME-Version: 1.0
In-Reply-To: <a6zvfTWG8HmL1m3CKsFlVVKFO4CznsabNKtz6u1vD1P4HVWcun3mWGHs11YE4exIKjC48U7t5383dTEbXZfYmMeFvHqNnrmzjp0izgkWFys=@codecraftsmen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <w1@codecraftsmen.org>, Xenomai <xenomai@xenomai.org>

On 26.11.19 18:33, Jeff Webb via Xenomai wrote:
> I have previously used make-kpkg to build deb packages for my Ubuntu systems.  This process worked, but the linux-headers package was never quite right.  I could not build my own kernel drivers (e.g. custom UDD drivers) on another system without copying the build directory over or monkeying with the headers package.
> 
> With my latest builds, I tried make deb-pkg with 4.19.84 and 4.4.199-cip39.  The linux-headers package built with this process *almost* works.  There were, however just a few Xenomai headers that were missing.  This following patch to 4.19.84 fixed the issue:
> 
> --- ../tmp/linux-4.19.84/scripts/package/builddeb2019-11-12 12:21:46.000000000 -0600
> +++ scripts/package/builddeb2019-11-18 17:46:34.948776288 -0600
> @@ -157,7 +157,7 @@
>    (cd $srctree; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) > "$objtree/debian/hdrsrcfiles"
>    (cd $srctree; find arch/*/include include scripts -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
>    (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
> -(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
> +(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"

How did you prepare the kernel with Xenomai, link or patch mode?

If link: This looks incomplete because link targets to Xenomai sources 
should be missing from the package.

If patch: Which links exactly do we miss here?

>    if grep -q '^CONFIG_STACK_VALIDATION=y' $KCONFIG_CONFIG ; then
>    (cd $objtree; find tools/objtool -type f -executable) >> "$objtree/debian/hdrobjfiles"
>    fi
> 
> 
> For 4.4.199-cip39, I had to pull in this same fix, plus a couple of others (backported from later kernels).  Here is that patch:

If you tell me the upstream commits, I could pick them up.

> 
> 
> --- ../tmp/linux-cip-4.4.199-cip39/scripts/package/builddeb2019-11-08 15:42:52.000000000 -0600
> +++ scripts/package/builddeb2019-11-19 16:16:40.651617778 -0600
> @@ -26,6 +26,8 @@
>    # Fix ownership and permissions
>    chown -R root:root "$pdir"
>    chmod -R go-w "$pdir"
> +# in case we are in a restrictive umask environment like 0077
> +chmod -R a+rX "$pdir"
> 
>    # Create the package
>    dpkg-gencontrol $forcearch -Vkernel:debarch="${debarch}" -p$pname -P"$pdir"
> @@ -322,10 +324,10 @@
> 
>    # Build kernel header package
>    (cd $srctree; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) > "$objtree/debian/hdrsrcfiles"
> -(cd $srctree; find arch/$SRCARCH/include include scripts -type f) >> "$objtree/debian/hdrsrcfiles"
> +(cd $srctree; find arch/$SRCARCH/include include scripts -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
>    (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
> -(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
> -(cd $objtree; find arch/$SRCARCH/include Module.symvers include scripts -type f) >> "$objtree/debian/hdrobjfiles"
> +(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
> +(cd $objtree; find arch/$SRCARCH/include Module.symvers include scripts -type f -o -type l) >> "$objtree/debian/hdrobjfiles"
>    destdir=$kernel_headers_dir/usr/src/linux-headers-$version
>    mkdir -p "$destdir"
>    (cd $srctree; tar -c -f - -T -) < "$objtree/debian/hdrsrcfiles" | (cd $destdir; tar -xf -)
> 
> 
> Hopefully these patches don't get mangled in transit, as I am pasting them inline.  I know I am not submitting these patches in the proper way, but I'm not sure what to submit a proper patch against and wanted to let others know about what I found.  I can resubmit these if they are appropriate for inclusion in Xenomai or the ipipe patch -- just let me know how this should be done.

Patches were mangled, indeed - some whitespaces got lost e.g. Thanks 
nevertheless.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

