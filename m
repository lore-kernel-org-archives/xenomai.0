Date: Tue, 26 Nov 2019 17:33:56 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Building deb packages
Message-ID: <a6zvfTWG8HmL1m3CKsFlVVKFO4CznsabNKtz6u1vD1P4HVWcun3mWGHs11YE4exIKjC48U7t5383dTEbXZfYmMeFvHqNnrmzjp0izgkWFys=@codecraftsmen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

I have previously used make-kpkg to build deb packages for my Ubuntu system=
s.  This process worked, but the linux-headers package was never quite righ=
t.  I could not build my own kernel drivers (e.g. custom UDD drivers) on an=
other system without copying the build directory over or monkeying with the=
 headers package.

With my latest builds, I tried make deb-pkg with 4.19.84 and 4.4.199-cip39.=
  The linux-headers package built with this process *almost* works.  There =
were, however just a few Xenomai headers that were missing.  This following=
 patch to 4.19.84 fixed the issue:

--- ../tmp/linux-4.19.84/scripts/package/builddeb2019-11-12 12:21:46.000000=
000 -0600
+++ scripts/package/builddeb2019-11-18 17:46:34.948776288 -0600
@@ -157,7 +157,7 @@
  (cd $srctree; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) =
> "$objtree/debian/hdrsrcfiles"
  (cd $srctree; find arch/*/include include scripts -type f -o -type l) >> =
"$objtree/debian/hdrsrcfiles"
  (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platfor=
ms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
-(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -ty=
pe d) -type f) >> "$objtree/debian/hdrsrcfiles"
+(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -ty=
pe d) -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
  if grep -q '^CONFIG_STACK_VALIDATION=3Dy' $KCONFIG_CONFIG ; then
  (cd $objtree; find tools/objtool -type f -executable) >> "$objtree/debian=
/hdrobjfiles"
  fi


For 4.4.199-cip39, I had to pull in this same fix, plus a couple of others =
(backported from later kernels).  Here is that patch:


--- ../tmp/linux-cip-4.4.199-cip39/scripts/package/builddeb2019-11-08 15:42=
:52.000000000 -0600
+++ scripts/package/builddeb2019-11-19 16:16:40.651617778 -0600
@@ -26,6 +26,8 @@
  # Fix ownership and permissions
  chown -R root:root "$pdir"
  chmod -R go-w "$pdir"
+# in case we are in a restrictive umask environment like 0077
+chmod -R a+rX "$pdir"

  # Create the package
  dpkg-gencontrol $forcearch -Vkernel:debarch=3D"${debarch}" -p$pname -P"$p=
dir"
@@ -322,10 +324,10 @@

  # Build kernel header package
  (cd $srctree; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) =
> "$objtree/debian/hdrsrcfiles"
-(cd $srctree; find arch/$SRCARCH/include include scripts -type f) >> "$obj=
tree/debian/hdrsrcfiles"
+(cd $srctree; find arch/$SRCARCH/include include scripts -type f -o -type =
l) >> "$objtree/debian/hdrsrcfiles"
  (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platfor=
ms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
-(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -ty=
pe d) -type f) >> "$objtree/debian/hdrsrcfiles"
-(cd $objtree; find arch/$SRCARCH/include Module.symvers include scripts -t=
ype f) >> "$objtree/debian/hdrobjfiles"
+(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -ty=
pe d) -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
+(cd $objtree; find arch/$SRCARCH/include Module.symvers include scripts -t=
ype f -o -type l) >> "$objtree/debian/hdrobjfiles"
  destdir=3D$kernel_headers_dir/usr/src/linux-headers-$version
  mkdir -p "$destdir"
  (cd $srctree; tar -c -f - -T -) < "$objtree/debian/hdrsrcfiles" | (cd $de=
stdir; tar -xf -)


Hopefully these patches don't get mangled in transit, as I am pasting them =
inline.  I know I am not submitting these patches in the proper way, but I'=
m not sure what to submit a proper patch against and wanted to let others k=
now about what I found.  I can resubmit these if they are appropriate for i=
nclusion in Xenomai or the ipipe patch -- just let me know how this should =
be done.

Thanks,

-Jeff


