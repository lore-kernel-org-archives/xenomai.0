MIME-Version: 1.0
References: <CAB9YM8hS5tg+mK_uVs3qe8A=4NXOk-KVJq1FXrVPRG5GcFU-EQ@mail.gmail.com>
 <b212b335-7aee-acd4-c809-3dafb937eb9e@siemens.com>
 <CAB9YM8i-cVW8SycKU64L3_9_miFT595WiGhtWDPXa7L5F6wOLw@mail.gmail.com>
 <239c15e7-dcd4-6f97-3a8c-7e4ddf374003@siemens.com>
 <CAB9YM8gHJ3NVpXLdfn85SBCVeBXywai91Tpk6m3KGzZZZKoAWw@mail.gmail.com>
In-Reply-To: <CAB9YM8gHJ3NVpXLdfn85SBCVeBXywai91Tpk6m3KGzZZZKoAWw@mail.gmail.com>
From: =?UTF-8?Q?Jo=C3=A3o_Costa?= <joaocostalapin@gmail.com>
Date: Fri, 11 Jun 2021 16:06:32 +0100
Message-ID: <CAB9YM8hGLamkJ=yN5cuD+T7mK3HoT4Ko8xBcTe=Xmj=0nyESmA@mail.gmail.com>
Subject: Re: problems installing Xenomai 3.1 in Ubuntu 20.04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Just remember to check the CONFIG_HYPERV parameter in the .config  (in
another thread I was advised to turn it off, it is not mentioned here [1]
[2]).
I disabled it (it was set to manual) but I didn't went far since multiple
errors still appear while compiling.


[1]
https://source.denx.de/Xenomai/xenomai/-/wikis/Configuring_For_X86_Based_Du=
al_Kernels
[2]
https://source.denx.de/Xenomai/xenomai/-/wikis/Troubleshooting#user-content=
-kernel-related-issues

Jo=C3=A3o Costa <joaocostalapin@gmail.com> escreveu no dia sexta, 11/06/202=
1
=C3=A0(s) 13:05:

> Thank you for your time and feedback.
> I have been trying to follow your instructions / the wiki but without
> success.
>
> Do not assume that I know what I am doing because clearly I do not. Each
> step forward is two steps behind.
>
> I started from scratch and once again errors are showing up when
> compiling. I think I took into consideration all the parameters indicated
> in the wiki but I am probably wrong since I still get a warning in make
> menuconfig (in attach, just like the .config file)
>
>
>
> *instructions*
>
> $ wget
> https://xenomai.org/downloads/xenomai/stable/latest/xenomai-3.1.tar.bz2
> $ tar -xvf xenomai-3.1.tar.bz2
> $ wget
> https://source.denx.de/Xenomai/ipipe-x86/-/archive/ipipe-core-5.4.105-x86=
-4/ipipe-x86-ipipe-core-5.4.105-x86-4.tar.gz
> $ tar -xvf ipipe-x86-ipipe-core-5.4.105-x86-4.tar.gz
>
> $ cd xenomai-3.1/scripts/
> $ ./prepare-kernel.sh --linux=3D/home/xxx/ipipe-x86-ipipe-core-5.4.105-x8=
6-4
> --arch=3Dx86_64
>
> $ cd ~/ipipe-x86-ipipe-core-5.4.105-x86-4/
>
> $ make menuconfig
>
> $ sudo CONCURRENCY_LEVEL=3D12 make-kpkg --rootcmd fakeroot --initrd
> --revision=3D1.0.0 kernel_image kernel_headers
>
>
> *CLI log*
>
>> xxx@hypertests:~/ipipe-x86-ipipe-core-5.4.105-x86-4$ sudo
>> CONCURRENCY_LEVEL=3D12 make-kpkg --rootcmd fakeroot --initrd --revision=
=3D1
>>                              .0.0 kernel_image kernel_headers
>>
>> exec make kpkg_version=3D13.018+nmu2 -f /usr/share/kernel-package/rulese=
t/
>> minimal.mk debian DEBIAN_REVISION=3D1.0.0  INITRD=3DYES  ROOT
>>                    _CMD=3Dfakeroot
>> =3D=3D=3D=3D=3D=3D making target debian/stamp/conf/minimal_debian [new p=
rereqs:
>> ]=3D=3D=3D=3D=3D=3D
>> This is kernel package version 13.018+nmu2.
>> test -d debian             || mkdir debian
>> test ! -e stamp-building || rm -f stamp-building
>> install -p -m 755 /usr/share/kernel-package/rules debian/rules
>> for file in ChangeLog  Control  Control.bin86 config templates.in rules;
>> do                                      \
>>             cp -f  /usr/share/kernel-package/$file ./debian/;
>>                   \
>>         done
>> cp: cannot stat '/usr/share/kernel-package/ChangeLog': No such file or
>> directory
>> for dir  in Config docs examples ruleset scripts pkg po;  do
>>                          \
>>           cp -af /usr/share/kernel-package/$dir  ./debian/;
>>                   \
>>         done
>> test -f debian/control || sed         -e 's/=3DV/5.4.105/g'  \
>>                 -e 's/=3DD/1.0.0/g'         -e 's/=3DA/amd64/g'  \
>>         -e 's/=3DSA//g'  \
>>         -e 's/=3DI//g'                                \
>>         -e 's/=3DCV/5.4/g'                            \
>>         -e 's/=3DM/Unknown Kernel Package Maintainer
>> <unknown@unconfigured.in.etc.kernel-pkg.conf>/g'
>> \
>>         -e 's/=3DST/linux/g'      -e 's/=3DB/x86_64/g'    \
>>                 -e 's/=3DR/initramfs-tools | linux-initramfs-tool,/g'
>>  /usr/share/kernel-package/Control > debian/control
>> test -f debian/changelog ||  sed -e 's/=3DV/5.4.105/g'       \
>>             -e 's/=3DD/1.0.0/g'        -e 's/=3DA/amd64/g'       \
>>             -e 's/=3DST/linux/g'     -e 's/=3DB/x86_64/g'         \
>>             -e 's/=3DM/Unknown Kernel Package Maintainer
>> <unknown@unconfigured.in.etc.kernel-pkg.conf>/g'
>>                                      \
>>              /usr/share/kernel-package/changelog > debian/changelog
>> chmod 0644 debian/control debian/changelog
>> test -d ./debian/stamp || mkdir debian/stamp
>> make -f debian/rules debian/stamp/conf/kernel-conf
>> make[1]: Entering directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-=
4'
>> =3D=3D=3D=3D=3D=3D making target debian/stamp/conf/kernel-conf [new prer=
eqs: ]=3D=3D=3D=3D=3D=3D
>> make    ARCH=3Dx86_64 \
>>                     oldconfig;
>> make[2]: Entering directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-=
4'
>> scripts/kconfig/conf  --oldconfig Kconfig
>> WARNING: unmet direct dependencies detected for PARAVIRT
>>   Depends on [n]: HYPERVISOR_GUEST [=3Dy] && !IPIPE [=3Dy]
>>   Selected by [m]:
>>   - HYPERV [=3Dm] && X86 [=3Dy] && ACPI [=3Dy] && X86_LOCAL_APIC [=3Dy] =
&&
>> HYPERVISOR_GUEST [=3Dy]
>> WARNING: unmet direct dependencies detected for PARAVIRT
>>   Depends on [n]: HYPERVISOR_GUEST [=3Dy] && !IPIPE [=3Dy]
>>   Selected by [m]:
>>   - HYPERV [=3Dm] && X86 [=3Dy] && ACPI [=3Dy] && X86_LOCAL_APIC [=3Dy] =
&&
>> HYPERVISOR_GUEST [=3Dy]
>> #
>> # No change to .config
>> #
>> make[2]: Leaving directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4=
'
>> make    ARCH=3Dx86_64 prepare
>> make[2]: Entering directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-=
4'
>>   SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
>>   SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
>>   SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
>>   SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
>>   HYPERCALLS arch/x86/include/generated/asm/xen-hypercalls.h
>>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
>>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
>>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
>>   HOSTCC  arch/x86/tools/relocs_32.o
>>   HOSTCC  arch/x86/tools/relocs_64.o
>>   HOSTCC  arch/x86/tools/relocs_common.o
>>   HOSTLD  arch/x86/tools/relocs
>>   HOSTCC  scripts/genksyms/genksyms.o
>>   YACC    scripts/genksyms/parse.tab.[ch]
>>   HOSTCC  scripts/genksyms/parse.tab.o
>>   LEX     scripts/genksyms/lex.lex.c
>>   HOSTCC  scripts/genksyms/lex.lex.o
>>   HOSTLD  scripts/genksyms/genksyms
>>   HOSTCC  scripts/selinux/genheaders/genheaders
>>   HOSTCC  scripts/selinux/mdp/mdp
>>   HOSTCC  scripts/bin2c
>>   HOSTCC  scripts/kallsyms
>>   HOSTCC  scripts/conmakehash
>>   HOSTCC  scripts/sortextable
>>   HOSTCC  scripts/asn1_compiler
>>   HOSTCC  scripts/sign-file
>>   HOSTCC  scripts/extract-cert
>>   HOSTCC  scripts/insert-sys-cert
>>   WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
>>   WRAP    arch/x86/include/generated/uapi/asm/errno.h
>>   WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
>>   WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
>>   WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
>>   WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
>>   WRAP    arch/x86/include/generated/uapi/asm/param.h
>>   WRAP    arch/x86/include/generated/uapi/asm/poll.h
>>   WRAP    arch/x86/include/generated/uapi/asm/resource.h
>>   WRAP    arch/x86/include/generated/uapi/asm/socket.h
>>   WRAP    arch/x86/include/generated/uapi/asm/sockios.h
>>   WRAP    arch/x86/include/generated/uapi/asm/termbits.h
>>   WRAP    arch/x86/include/generated/uapi/asm/termios.h
>>   WRAP    arch/x86/include/generated/uapi/asm/types.h
>>   WRAP    arch/x86/include/generated/asm/dma-contiguous.h
>>   WRAP    arch/x86/include/generated/asm/early_ioremap.h
>>   WRAP    arch/x86/include/generated/asm/export.h
>>   WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
>>   WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
>>   WRAP    arch/x86/include/generated/asm/mmiowb.h
>>   UPD     include/config/kernel.release
>>   UPD     include/generated/uapi/linux/version.h
>>   UPD     include/generated/utsrelease.h
>>   CC      scripts/mod/empty.o
>>   HOSTCC  scripts/mod/mk_elfconfig
>>   MKELF   scripts/mod/elfconfig.h
>>   HOSTCC  scripts/mod/modpost.o
>>   CC      scripts/mod/devicetable-offsets.s
>>   UPD     scripts/mod/devicetable-offsets.h
>>   HOSTCC  scripts/mod/file2alias.o
>>   HOSTCC  scripts/mod/sumversion.o
>>   HOSTLD  scripts/mod/modpost
>>   CC      kernel/bounds.s
>>   UPD     include/generated/bounds.h
>>   UPD     include/generated/timeconst.h
>>   CC      arch/x86/kernel/asm-offsets.s
>>   UPD     include/generated/asm-offsets.h
>>   CALL    scripts/checksyscalls.sh
>>   CALL    scripts/atomic/check-atomics.sh
>>   DESCEND  objtool
>>   HOSTCC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/fixdep.o
>>   HOSTLD
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/fixdep-in.o
>>   LINK
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/fixdep
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/exec-cmd.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/help.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/pager.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/parse-options=
.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/run-command.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/sigchain.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/subcmd-config=
.o
>>   LD
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/libsubcmd-in.=
o
>>   AR
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/libsubcmd.a
>>   MKDIR
>>  /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/arch/x86/lib=
/
>>   GEN
>>  /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/arch/x86/lib=
/inat-tables.c
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/arch/x86/deco=
de.o
>>   LD
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/arch/x86/objt=
ool-in.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/builtin-check=
.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/builtin-orc.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/check.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/orc_gen.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/orc_dump.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/elf.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/special.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/objtool.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/libstring.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/libctype.o
>>   CC
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/str_error_r.o
>>   LD
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/objtool-in.o
>>   LINK
>> /home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4/tools/objtool/objtool
>> make[2]: Leaving directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4=
'
>> echo done > debian/stamp/conf/kernel-conf
>> make[1]: Leaving directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4=
'
>> make -f debian/rules debian/stamp/conf/full-changelog
>> make[1]: Entering directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-=
4'
>> =3D=3D=3D=3D=3D=3D making target debian/stamp/conf/full-changelog [new p=
rereqs:
>> ]=3D=3D=3D=3D=3D=3D
>> for file in ChangeLog  Control  Control.bin86 config templates.in rules;
>> do                             \
>>      cp -f  /usr/share/kernel-package/$file ./debian/;                  =
\
>> done
>> cp: cannot stat '/usr/share/kernel-package/ChangeLog': No such file or
>> directory
>> for dir  in Config docs examples ruleset scripts pkg po;        do
>>                        \
>>    cp -af /usr/share/kernel-package/$dir  ./debian/;
>>        \
>> done
>> install -p -m 755 /usr/share/kernel-package/rules debian/rules
>> sed         -e 's/=3DV/5.4.105/g'  \
>>                 -e 's/=3DD/1.0.0/g'         -e 's/=3DA/amd64/g'  \
>>         -e 's/=3DSA//g'  \
>>         -e 's/=3DI//g'                                \
>>         -e 's/=3DCV/5.4/g'                            \
>>         -e 's/=3DM/Unknown Kernel Package Maintainer
>> <unknown@unconfigured.in.etc.kernel-pkg.conf>/g'
>> \
>>         -e 's/=3DST/linux/g'      -e 's/=3DB/x86_64/g'    \
>>                 -e 's/=3DR/initramfs-tools | linux-initramfs-tool,/g'
>>  /usr/share/kernel-package/Control > debian/control
>> sed -e 's/=3DV/5.4.105/g' -e 's/=3DD/1.0.0/g'             \
>>     -e 's/=3DA/amd64/g' -e 's/=3DM/Unknown Kernel Package Maintainer
>> <unknown@unconfigured.in.etc.kernel-pkg.conf>/g' \
>>     -e 's/=3DST/linux/g'   -e 's/=3DB/x86_64/g'           \
>>         /usr/share/kernel-package/changelog > debian/changelog
>> chmod 0644 debian/control debian/changelog
>> make -f debian/rules debian/stamp/conf/kernel-conf
>> make[2]: Entering directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-=
4'
>> make[2]: 'debian/stamp/conf/kernel-conf' is up to date.
>> make[2]: Leaving directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4=
'
>> make[1]: Leaving directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4=
'
>> echo done > debian/stamp/conf/minimal_debian
>> exec debian/rules  DEBIAN_REVISION=3D1.0.0  INITRD=3DYES  ROOT_CMD=3Dfak=
eroot
>>  kernel_image kernel_headers
>> =3D=3D=3D=3D=3D=3D making target debian/stamp/conf/vars [new prereqs: ]=
=3D=3D=3D=3D=3D=3D
>> WARNING: unmet direct dependencies detected for PARAVIRT
>>   Depends on [n]: HYPERVISOR_GUEST [=3Dy] && !IPIPE [=3Dy]
>>   Selected by [m]:
>>   - HYPERV [=3Dm] && X86 [=3Dy] && ACPI [=3Dy] && X86_LOCAL_APIC [=3Dy] =
&&
>> HYPERVISOR_GUEST [=3Dy]
>> WARNING: unmet direct dependencies detected for PARAVIRT
>>   Depends on [n]: HYPERVISOR_GUEST [=3Dy] && !IPIPE [=3Dy]
>>   Selected by [m]:
>>   - HYPERV [=3Dm] && X86 [=3Dy] && ACPI [=3Dy] && X86_LOCAL_APIC [=3Dy] =
&&
>> HYPERVISOR_GUEST [=3Dy]
>> WARNING: unmet direct dependencies detected for PARAVIRT
>>   Depends on [n]: HYPERVISOR_GUEST [=3Dy] && !IPIPE [=3Dy]
>>   Selected by [m]:
>>   - HYPERV [=3Dm] && X86 [=3Dy] && ACPI [=3Dy] && X86_LOCAL_APIC [=3Dy] =
&&
>> HYPERVISOR_GUEST [=3Dy]
>> =3D=3D=3D=3D=3D=3D making target debian/stamp/build/kernel [new prereqs:=
 vars]=3D=3D=3D=3D=3D=3D
>> This is kernel package version 13.018+nmu2.
>> restore_upstream_debianization
>> test ! -f scripts/package/builddeb.kpkg-dist || mv -f
>> scripts/package/builddeb.kpkg-dist scripts/package/builddeb
>> test ! -f scripts/package/Makefile.kpkg-dist || mv -f
>> scripts/package/Makefile.kpkg-dist scripts/package/Makefile
>> /usr/bin/make -j12   ARCH=3Dx86_64 \
>>                      bzImage
>> make[1]: Entering directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-=
4'
>>   DESCEND  objtool
>>   CALL    scripts/atomic/check-atomics.sh
>>   CALL    scripts/checksyscalls.sh
>>   CHK     include/generated/compile.h
>>   CC      init/main.o
>>   HOSTCC  usr/gen_init_cpio
>>   CC      arch/x86/xenomai/machine.o
>>   CC      init/do_mounts.o
>>   CC      arch/x86/xenomai/thread.o
>>   CC      init/do_mounts_initrd.o
>>   UPD     include/generated/compile.h
>>   CC      arch/x86/hyperv/hv_init.o
>>   CC      arch/x86/events/amd/core.o
>>   CC      arch/x86/events/intel/core.o
>>   GEN     usr/initramfs_data.cpio
>>   CC      arch/x86/entry/vdso/vma.o
>> arch/x86/xenomai/thread.c: In function =E2=80=98xnarch_leave_root=E2=80=
=99:
>> arch/x86/xenomai/thread.c:475:2: error: too many arguments to function
>> =E2=80=98switch_fpu_finish=E2=80=99
>>   475 |  switch_fpu_finish(&current->thread.fpu, smp_processor_id());
>>       |  ^~~~~~~~~~~~~~~~~
>> In file included from arch/x86/xenomai/include/asm/xenomai/wrappers.h:44=
,
>>                  from include/xenomai/cobalt/kernel/timer.h:28,
>>                  from include/xenomai/cobalt/kernel/thread.h:27,
>>                  from arch/x86/xenomai/thread.c:25:
>> ./arch/x86/include/asm/fpu/internal.h:594:20: note: declared here
>>   594 | static inline void switch_fpu_finish(struct fpu *new_fpu)
>>       |                    ^~~~~~~~~~~~~~~~~
>> make[2]: *** [scripts/Makefile.build:262: arch/x86/xenomai/thread.o]
>> Error 1
>> make[2]: *** Waiting for unfinished jobs....
>>   CC      arch/x86/events/intel/bts.o
>>   CC      arch/x86/crypto/crc32c-intel_glue.o
>>   CC      kernel/bpf/core.o
>>   AS      usr/initramfs_data.o
>>   CC      arch/x86/events/core.o
>>   AR      usr/built-in.a
>> make[2]: *** No rule to make target 'debian/canonical-certs.pem', needed
>> by 'certs/x509_certificate_list'.  Stop.
>> make[2]: *** Waiting for unfinished jobs....
>>   CC      certs/system_keyring.o
>>   CC      arch/x86/entry/vdso/vdso32-setup.o
>> make[1]: *** [Makefile:1726: arch/x86/xenomai] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>>   CC      arch/x86/events/amd/uncore.o
>>   AS      arch/x86/crypto/crc32c-pcl-intel-asm_64.o
>>   CC      arch/x86/hyperv/mmu.o
>>   LDS     arch/x86/entry/vdso/vdso.lds
>>   CC      arch/x86/events/intel/ds.o
>>   AR      arch/x86/crypto/built-in.a
>>   AS      arch/x86/entry/vdso/vdso-note.o
>>   CC      init/do_mounts_md.o
>>   CC      arch/x86/hyperv/nested.o
>>   CC      arch/x86/hyperv/hv_apic.o
>> make[1]: *** [Makefile:1726: certs] Error 2
>>   CC      arch/x86/entry/vdso/vclock_gettime.o
>>   CC      kernel/bpf/syscall.o
>>   CC      kernel/cgroup/cgroup.o
>>   CC      arch/x86/events/amd/ibs.o
>>   CC      arch/x86/events/intel/knc.o
>>   CC      arch/x86/entry/vdso/vgetcpu.o
>>   CC      init/initramfs.o
>>   CC      arch/x86/events/probe.o
>>   HOSTCC  arch/x86/entry/vdso/vdso2c
>>   LDS     arch/x86/entry/vdso/vdsox32.lds
>>   CC      arch/x86/hyperv/hv_spinlock.o
>>   X32     arch/x86/entry/vdso/vdso-note-x32.o
>>   X32     arch/x86/entry/vdso/vclock_gettime-x32.o
>>   X32     arch/x86/entry/vdso/vgetcpu-x32.o
>>   LDS     arch/x86/entry/vdso/vdso32/vdso32.lds
>>   CC      arch/x86/events/msr.o
>>   CC      arch/x86/events/intel/lbr.o
>>   CC      arch/x86/entry/vdso/vdso32/vclock_gettime.o
>>   CC      arch/x86/events/amd/iommu.o
>>   AS      arch/x86/entry/vdso/vdso32/note.o
>>   CC      kernel/debug/debug_core.o
>>   CC      kernel/debug/kdb/kdb_io.o
>>   CC      kernel/debug/kdb/kdb_main.o
>>   AR      arch/x86/hyperv/built-in.a
>>   CC      kernel/bpf/verifier.o
>>   CC      kernel/debug/kdb/kdb_support.o
>>   CC      init/calibrate.o
>>   CC      init/init_task.o
>>   AS      arch/x86/entry/vdso/vdso32/system_call.o
>>   AS      arch/x86/entry/vdso/vdso32/sigreturn.o
>>   CC      kernel/debug/gdbstub.o
>>   CC      arch/x86/events/intel/p4.o
>>   AR      arch/x86/events/amd/built-in.a
>>   CC      arch/x86/events/intel/p6.o
>>   VDSO    arch/x86/entry/vdso/vdso64.so.dbg
>>   CC      kernel/bpf/inode.o
>>   VDSO    arch/x86/entry/vdso/vdsox32.so.dbg
>>   VDSO    arch/x86/entry/vdso/vdso32.so.dbg
>>   OBJCOPY arch/x86/entry/vdso/vdso64.so
>>   OBJCOPY arch/x86/entry/vdso/vdsox32.so
>>   OBJCOPY arch/x86/entry/vdso/vdso32.so
>>   VDSO2C  arch/x86/entry/vdso/vdso-image-64.c
>>   VDSO2C  arch/x86/entry/vdso/vdso-image-x32.c
>>   VDSO2C  arch/x86/entry/vdso/vdso-image-32.c
>>   CC      arch/x86/entry/vdso/vdso-image-64.o
>>   CC      arch/x86/entry/vdso/vdso-image-x32.o
>>   CC      kernel/debug/kdb/kdb_bt.o
>>   GENKDB  kernel/debug/kdb/gen-kdb_cmds.c
>>   CC      init/version.o
>>   CC      arch/x86/entry/vsyscall/vsyscall_64.o
>>   CC      kernel/cgroup/rstat.o
>>   AS      arch/x86/entry/vsyscall/vsyscall_emu_64.o
>>   CC      arch/x86/entry/vdso/vdso-image-32.o
>>   CC      kernel/bpf/helpers.o
>>   CC      kernel/cgroup/namespace.o
>>   CC      arch/x86/events/intel/pt.o
>>   CC      arch/x86/events/intel/uncore.o
>>   CC      arch/x86/ia32/sys_ia32.o
>>   AR      arch/x86/entry/vdso/built-in.a
>>   CC      arch/x86/ia32/ia32_signal.o
>>   CC      kernel/debug/kdb/kdb_bp.o
>>   AR      init/built-in.a
>>   CC      kernel/debug/kdb/kdb_debugger.o
>>   AR      arch/x86/entry/vsyscall/built-in.a
>>   AS      arch/x86/entry/entry_64.o
>>   CC      arch/x86/ia32/audit.o
>>   CC      kernel/cgroup/cgroup-v1.o
>>   CC      kernel/cgroup/freezer.o
>>   CC      kernel/debug/kdb/kdb_keyboard.o
>>   CC      kernel/cgroup/legacy_freezer.o
>>   CC      kernel/cgroup/pids.o
>>   CC      kernel/dma/mapping.o
>>   AR      arch/x86/ia32/built-in.a
>>   CC      kernel/events/core.o
>>   CC      kernel/cgroup/rdma.o
>>   CC      arch/x86/kernel/acpi/boot.o
>>   AS      arch/x86/entry/thunk_64.o
>>   CC      kernel/dma/direct.o
>>   CC      arch/x86/events/intel/uncore_nhmex.o
>>   CC      kernel/debug/kdb/gen-kdb_cmds.o
>>   AR      kernel/debug/kdb/built-in.a
>>   CC      arch/x86/events/intel/uncore_snb.o
>>   AR      kernel/debug/built-in.a
>>   CC      arch/x86/kernel/apic/apic.o
>>   CC      kernel/ipipe/core.o
>>   CC      kernel/bpf/tnum.o
>>   CC      kernel/ipipe/timer.o
>>   CC      arch/x86/entry/syscall_64.o
>>   CC      arch/x86/entry/common.o
>>   CC      arch/x86/kernel/acpi/sleep.o
>> kernel/ipipe/core.c: In function =E2=80=98__ipipe_spin_lock_irqsave=E2=
=80=99:
>> kernel/ipipe/core.c:547:9: error: implicit declaration of function
>> =E2=80=98arch_mangle_irq_bits=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
>>   547 |  return arch_mangle_irq_bits(s, flags);
>>       |         ^~~~~~~~~~~~~~~~~~~~
>>   CC      kernel/bpf/hashtab.o
>> kernel/ipipe/core.c: In function =E2=80=98__ipipe_spin_unlock_irqrestore=
=E2=80=99:
>> kernel/ipipe/core.c:574:7: error: implicit declaration of function
>> =E2=80=98arch_demangle_irq_bits=E2=80=99; did you mean =E2=80=98arch_ear=
ly_irq_init=E2=80=99?
>>                     [-Werror=3Dimplicit-function-declaration]
>>   574 |  if (!arch_demangle_irq_bits(&x))
>>       |       ^~~~~~~~~~~~~~~~~~~~~~
>>       |       arch_early_irq_init
>>   CC      kernel/cgroup/cpuset.o
>>   CC      kernel/dma/dummy.o
>>   AS      arch/x86/entry/entry_64_compat.o
>>   CC      arch/x86/events/intel/uncore_snbep.o
>> cc1: some warnings being treated as errors
>> make[3]: *** [scripts/Makefile.build:262: kernel/ipipe/core.o] Error 1
>> make[3]: *** Waiting for unfinished jobs....
>>   AS      arch/x86/kernel/acpi/wakeup_64.o
>>   CC      arch/x86/mm/init.o
>>   CC      kernel/dma/virt.o
>> make[2]: *** [scripts/Makefile.build:496: kernel/ipipe] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>>   CC      arch/x86/entry/syscall_32.o
>>   CC      arch/x86/kernel/acpi/apei.o
>>   CC      kernel/events/ring_buffer.o
>>   CC      kernel/dma/swiotlb.o
>>   AR      arch/x86/entry/built-in.a
>>   CC      arch/x86/kernel/apic/apic_common.o
>>   CC      arch/x86/kernel/acpi/cppc_msr.o
>>   CC      arch/x86/net/bpf_jit_comp.o
>>   CC      arch/x86/mm/init_64.o
>>   CC      arch/x86/mm/fault.o
>>   AR      arch/x86/events/intel/built-in.a
>>   AR      arch/x86/events/built-in.a
>>   CC      kernel/bpf/arraymap.o
>>   CC      arch/x86/kernel/apic/apic_noop.o
>>   CC      kernel/bpf/percpu_freelist.o
>>   CC      arch/x86/kernel/acpi/cstate.o
>>   CC      arch/x86/kernel/apic/ipi.o
>>   CC      arch/x86/kernel/cpu/mce/core.o
>>   AR      kernel/dma/built-in.a
>>   CC      arch/x86/kernel/cpu/mce/severity.o
>>   CC      kernel/events/callchain.o
>>   CC      arch/x86/kernel/cpu/mce/genpool.o
>>   AR      arch/x86/net/built-in.a
>>   CC      arch/x86/kernel/apic/vector.o
>>   CC      arch/x86/kernel/cpu/mce/intel.o
>>   CC      kernel/events/hw_breakpoint.o
>>   CC      kernel/bpf/bpf_lru_list.o
>>   AR      kernel/cgroup/built-in.a
>>   CC      arch/x86/kernel/fpu/init.o
>>   CC      arch/x86/kernel/kprobes/core.o
>>   CC      arch/x86/mm/ioremap.o
>>   AR      arch/x86/kernel/acpi/built-in.a
>>   CC      arch/x86/kernel/apic/hw_nmi.o
>>   CC      kernel/events/uprobes.o
>>   CC      arch/x86/kernel/apic/io_apic.o
>>   CC      kernel/bpf/lpm_trie.o
>>   CC      arch/x86/kernel/cpu/mce/amd.o
>>   CC      arch/x86/kernel/fpu/bugs.o
>>   CC      arch/x86/kernel/kprobes/opt.o
>>   CC      arch/x86/kernel/fpu/core.o
>>   CC      arch/x86/kernel/cpu/mce/threshold.o
>>   CC      arch/x86/kernel/fpu/regset.o
>>   CC      kernel/bpf/map_in_map.o
>>   CC      arch/x86/kernel/cpu/mce/therm_throt.o
>>   CC      arch/x86/kernel/fpu/signal.o
>>   CC      arch/x86/kernel/apic/msi.o
>>   CC      arch/x86/kernel/apic/apic_numachip.o
>>   CC      kernel/bpf/local_storage.o
>>   AR      kernel/events/built-in.a
>>   CC      arch/x86/mm/extable.o
>>   CC      kernel/bpf/queue_stack_maps.o
>>   AR      arch/x86/kernel/kprobes/built-in.a
>>   CC      arch/x86/kernel/apic/x2apic_phys.o
>>   CC      arch/x86/mm/pageattr.o
>>   CC      arch/x86/kernel/apic/x2apic_cluster.o
>>   CC      arch/x86/kernel/fpu/xstate.o
>>   CC      arch/x86/mm/mmap.o
>>   CC      arch/x86/mm/pat.o
>>   CC      kernel/bpf/disasm.o
>>   CC      arch/x86/kernel/apic/apic_flat_64.o
>>   CC      arch/x86/kernel/cpu/mce/apei.o
>>   CC      arch/x86/kernel/apic/probe_64.o
>>   CC      arch/x86/kernel/cpu/mce/dev-mcelog.o
>>   CC      kernel/bpf/btf.o
>>   AR      arch/x86/platform/atom/built-in.a
>>   CC      arch/x86/platform/pvh/enlighten.o
>>   AR      arch/x86/platform/ce4100/built-in.a
>>   CC      arch/x86/platform/efi/quirks.o
>>   AS      arch/x86/platform/pvh/head.o
>>   CC      arch/x86/platform/efi/efi.o
>>   CC      arch/x86/mm/pgtable.o
>>   CC      arch/x86/platform/efi/efi_64.o
>>   AR      arch/x86/platform/pvh/built-in.a
>>   AS      arch/x86/platform/efi/efi_stub_64.o
>>   AR      arch/x86/kernel/apic/built-in.a
>>   CC      arch/x86/kernel/process_64.o
>>   AR      arch/x86/kernel/fpu/built-in.a
>>   CC      arch/x86/purgatory/purgatory.o
>>   CC      arch/x86/kernel/signal.o
>>   CC      arch/x86/mm/physaddr.o
>>   AR      arch/x86/kernel/cpu/mce/built-in.a
>>   CC      arch/x86/kernel/cpu/microcode/core.o
>>   AS      arch/x86/purgatory/stack.o
>>   AS      arch/x86/platform/efi/efi_thunk_64.o
>>   CC      arch/x86/kernel/cpu/microcode/intel.o
>>   AS      arch/x86/purgatory/setup-x86_64.o
>>   CC      arch/x86/realmode/init.o
>>   CC      arch/x86/purgatory/sha256.o
>>   CC      kernel/bpf/devmap.o
>>   CC      arch/x86/kernel/cpu/mtrr/mtrr.o
>>   AS      arch/x86/realmode/rm/header.o
>>   CC      arch/x86/kernel/signal_compat.o
>>   AS      arch/x86/realmode/rm/trampoline_64.o
>>   CC      arch/x86/kernel/cpu/microcode/amd.o
>>   CC      arch/x86/mm/setup_nx.o
>>   AS      arch/x86/realmode/rm/stack.o
>>   AS      arch/x86/purgatory/entry64.o
>>   AS      arch/x86/realmode/rm/reboot.o
>>   CC      arch/x86/purgatory/string.o
>>   CC      arch/x86/kernel/cpu/mtrr/if.o
>>   CC      arch/x86/kernel/cpu/mtrr/generic.o
>>   AR      arch/x86/platform/efi/built-in.a
>>   CC      arch/x86/xen/enlighten.o
>>   AR      arch/x86/platform/geode/built-in.a
>>   AS      arch/x86/realmode/rm/wakeup_asm.o
>>   AR      arch/x86/platform/goldfish/built-in.a
>>   CC      arch/x86/platform/intel/iosf_mbi.o
>>   CC      arch/x86/mm/tlb.o
>>   CC      arch/x86/realmode/rm/wakemain.o
>>   CC      arch/x86/kernel/traps.o
>>   AR      arch/x86/kernel/cpu/microcode/built-in.a
>>   CC      arch/x86/realmode/rm/video-mode.o
>>   LD      arch/x86/purgatory/purgatory.ro
>>   AS      arch/x86/realmode/rm/copy.o
>>   BIN2C   arch/x86/purgatory/kexec-purgatory.c
>>   CC      kernel/bpf/cpumap.o
>>   CC      arch/x86/purgatory/kexec-purgatory.o
>>   CC      kernel/bpf/xskmap.o
>>   CC      arch/x86/kernel/cpu/resctrl/core.o
>>   AS      arch/x86/realmode/rm/bioscall.o
>>   CC      arch/x86/realmode/rm/regs.o
>>   CC      arch/x86/xen/mmu.o
>>   AR      arch/x86/purgatory/built-in.a
>>   CC      arch/x86/kernel/idt.o
>>   CC      arch/x86/realmode/rm/video-vga.o
>>   CC      arch/x86/xen/time.o
>>   CC      arch/x86/realmode/rm/video-vesa.o
>>   CC      arch/x86/realmode/rm/video-bios.o
>>   CC      arch/x86/kernel/cpu/mtrr/cleanup.o
>>   CC      arch/x86/mm/cpu_entry_area.o
>>   AR      arch/x86/platform/intel/built-in.a
>>   PASYMS  arch/x86/realmode/rm/pasyms.h
>>   LDS     arch/x86/realmode/rm/realmode.lds
>>   AR      arch/x86/platform/intel-mid/built-in.a
>>   CC      arch/x86/mm/pat_rbtree.o
>>   CC      kernel/bpf/offload.o
>>   CC      arch/x86/kernel/cpu/resctrl/rdtgroup.o
>>   LD      arch/x86/realmode/rm/realmode.elf
>>   RELOCS  arch/x86/realmode/rm/realmode.relocs
>>   AR      arch/x86/platform/intel-quark/built-in.a
>>   OBJCOPY arch/x86/realmode/rm/realmode.bin
>>   CC      arch/x86/mm/hugetlbpage.o
>>   AS      arch/x86/realmode/rmpiggy.o
>>   AR      arch/x86/platform/iris/built-in.a
>>   AR      arch/x86/platform/olpc/built-in.a
>>   AR      arch/x86/realmode/built-in.a
>>   AR      arch/x86/platform/scx200/built-in.a
>>   AR      arch/x86/platform/ts5500/built-in.a
>>   CC      arch/x86/mm/dump_pagetables.o
>>   CC      arch/x86/platform/sfi/sfi.o
>>   CC      arch/x86/mm/kmmio.o
>>   CC      arch/x86/mm/pf_in.o
>>   CC      arch/x86/xen/grant-table.o
>>   AR      arch/x86/platform/uv/built-in.a
>>   AR      arch/x86/kernel/cpu/mtrr/built-in.a
>>   CC      arch/x86/xen/suspend.o
>>   CC      arch/x86/kernel/irq.o
>>   CC      arch/x86/xen/enlighten_hvm.o
>>   CC      arch/x86/xen/mmu_hvm.o
>>   AR      arch/x86/platform/sfi/built-in.a
>>   CC      arch/x86/xen/suspend_hvm.o
>>   AR      arch/x86/platform/built-in.a
>>   CC      arch/x86/xen/platform-pci-unplug.o
>>   CC      arch/x86/mm/mmio-mod.o
>>   CC      arch/x86/kernel/cpu/resctrl/monitor.o
>>   CC      arch/x86/xen/setup.o
>>   CC      kernel/bpf/stackmap.o
>>   CC      arch/x86/xen/apic.o
>>   CC      arch/x86/xen/pmu.o
>>   CC      kernel/bpf/cgroup.o
>>   CC      kernel/bpf/reuseport_array.o
>>   CC      arch/x86/xen/suspend_pv.o
>>   CC      arch/x86/kernel/irq_64.o
>>   CC      arch/x86/kernel/cpu/resctrl/ctrlmondata.o
>>   CC      arch/x86/kernel/cpu/cacheinfo.o
>>   CC      arch/x86/mm/numa.o
>>   CC      arch/x86/kernel/cpu/scattered.o
>>   CC      arch/x86/kernel/cpu/resctrl/pseudo_lock.o
>>   CC      arch/x86/mm/numa_64.o
>>   CC      arch/x86/mm/amdtopology.o
>>   CC      arch/x86/kernel/dumpstack_64.o
>>   CC      arch/x86/xen/p2m.o
>>   CC      arch/x86/mm/srat.o
>>   CC      arch/x86/xen/enlighten_pv.o
>>   CC      arch/x86/xen/mmu_pv.o
>>   CC      arch/x86/kernel/time.o
>>   CC      arch/x86/xen/irq.o
>>   CC      arch/x86/kernel/cpu/topology.o
>>   CC      arch/x86/mm/mpx.o
>>   CC      arch/x86/mm/pkeys.o
>>   CC      arch/x86/kernel/cpu/common.o
>>   CC      arch/x86/kernel/ioport.o
>>   CC      arch/x86/mm/kaslr.o
>>   CC      arch/x86/kernel/dumpstack.o
>>   AR      arch/x86/kernel/cpu/resctrl/built-in.a
>>   CC      arch/x86/kernel/cpu/rdrand.o
>>   AR      kernel/bpf/built-in.a
>> make[1]: *** [Makefile:1726: kernel] Error 2
>>   CC      arch/x86/mm/pti.o
>>   CC      arch/x86/kernel/cpu/match.o
>>   CC      arch/x86/xen/multicalls.o
>>   CC      arch/x86/kernel/cpu/bugs.o
>> arch/x86/xen/enlighten_pv.o: warning: objtool: xen_cpuid()+0x20: can't
>> find jump dest instruction at .text+0x97
>>   CC      arch/x86/kernel/cpu/aperfmperf.o
>>   AS      arch/x86/xen/xen-asm.o
>>   CC      arch/x86/kernel/nmi.o
>>   AS      arch/x86/xen/xen-asm_64.o
>>   CC      arch/x86/kernel/ldt.o
>>   CC      arch/x86/kernel/setup.o
>>   CC      arch/x86/kernel/cpu/cpuid-deps.o
>>   CC      arch/x86/kernel/x86_init.o
>>   CC      arch/x86/mm/mem_encrypt.o
>>   CC      arch/x86/kernel/cpu/umwait.o
>>   CC      arch/x86/xen/enlighten_pvh.o
>>   CC      arch/x86/kernel/i8259.o
>>   CC      arch/x86/mm/mem_encrypt_identity.o
>>   AS      arch/x86/mm/mem_encrypt_boot.o
>>   CC      arch/x86/xen/trace.o
>>   CC      arch/x86/xen/smp.o
>>   CC      arch/x86/xen/smp_pv.o
>>   CC      arch/x86/xen/smp_hvm.o
>>   CC      arch/x86/kernel/cpu/proc.o
>>   CC      arch/x86/kernel/irqinit.o
>>   MKCAP   arch/x86/kernel/cpu/capflags.c
>>   CC      arch/x86/kernel/cpu/powerflags.o
>>   CC      arch/x86/kernel/irq_work.o
>>   AR      arch/x86/mm/built-in.a
>>   CC      arch/x86/xen/spinlock.o
>>   CC      arch/x86/kernel/cpu/intel.o
>>   CC      arch/x86/xen/vga.o
>>   CC      arch/x86/kernel/cpu/intel_pconfig.o
>>   CC      arch/x86/xen/pci-swiotlb-xen.o
>>   CC      arch/x86/kernel/probe_roms.o
>>   CC      arch/x86/kernel/cpu/tsx.o
>>   CC      arch/x86/xen/efi.o
>>   CC      arch/x86/kernel/cpu/intel_epb.o
>>   CC      arch/x86/kernel/cpu/amd.o
>>   CC      arch/x86/kernel/cpu/hygon.o
>>   CC      arch/x86/kernel/sys_x86_64.o
>>   CC      arch/x86/kernel/espfix_64.o
>>   CC      arch/x86/kernel/ksysfs.o
>>   CC      arch/x86/kernel/cpu/centaur.o
>>   CC      arch/x86/kernel/cpu/zhaoxin.o
>>   CC      arch/x86/kernel/bootflag.o
>>   CC      arch/x86/kernel/e820.o
>>   CC      arch/x86/kernel/pci-dma.o
>>   AR      arch/x86/xen/built-in.a
>>   CC      arch/x86/kernel/cpu/perfctr-watchdog.o
>>   CC      arch/x86/kernel/cpu/vmware.o
>>   CC      arch/x86/kernel/cpu/hypervisor.o
>>   CC      arch/x86/kernel/quirks.o
>>   CC      arch/x86/kernel/topology.o
>>   CC      arch/x86/kernel/kdebugfs.o
>>   CC      arch/x86/kernel/cpu/mshyperv.o
>>   CC      arch/x86/kernel/alternative.o
>>   CC      arch/x86/kernel/i8253.o
>>   CC      arch/x86/kernel/cpu/acrn.o
>>   CC      arch/x86/kernel/hw_breakpoint.o
>>   CC      arch/x86/kernel/tsc.o
>>   CC      arch/x86/kernel/tsc_msr.o
>>   CC      arch/x86/kernel/io_delay.o
>>   CC      arch/x86/kernel/rtc.o
>>   CC      arch/x86/kernel/pci-iommu_table.o
>>   AS      arch/x86/kernel/irqflags.o
>>   CC      arch/x86/kernel/resource.o
>>   CC      arch/x86/kernel/process.o
>>   CC      arch/x86/kernel/ptrace.o
>>   CC      arch/x86/kernel/tls.o
>>   CC      arch/x86/kernel/step.o
>>   CC      arch/x86/kernel/tboot.o
>>   CC      arch/x86/kernel/i8237.o
>>   CC      arch/x86/kernel/stacktrace.o
>>   CC      arch/x86/kernel/reboot.o
>> arch/x86/kernel/process.c: In function =E2=80=98mwait_idle=E2=80=99:
>> arch/x86/kernel/process.c:699:4: error: implicit declaration of function
>> =E2=80=98__ipipe_halt_root=E2=80=99; did you mean =E2=80=98ipipe_test_ro=
ot=E2=80=99? [-W
>>                error=3Dimplicit-function-declaration]
>>   699 |    __ipipe_halt_root(1);
>>       |    ^~~~~~~~~~~~~~~~~
>>       |    ipipe_test_root
>>   CC      arch/x86/kernel/early-quirks.o
>>   CC      arch/x86/kernel/ipipe.o
>>   CC      arch/x86/kernel/smp.o
>>   CC      arch/x86/kernel/smpboot.o
>> cc1: some warnings being treated as errors
>> make[3]: *** [scripts/Makefile.build:262: arch/x86/kernel/process.o]
>> Error 1
>> make[3]: *** Waiting for unfinished jobs....
>>   CC      arch/x86/kernel/tsc_sync.o
>>   CC      arch/x86/kernel/cpu/capflags.o
>>   AR      arch/x86/kernel/cpu/built-in.a
>> make[2]: *** [scripts/Makefile.build:496: arch/x86/kernel] Error 2
>> make[1]: *** [Makefile:1726: arch/x86] Error 2
>> make[1]: Leaving directory '/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4=
'
>> make: *** [debian/ruleset/targets/common.mk:301:
>> debian/stamp/build/kernel] Error 2
>> xxx@hypertests:~/ipipe-x86-ipipe-core-5.4.105-x86-4$
>>
>>
> Jan Kiszka <jan.kiszka@siemens.com> escreveu no dia ter=C3=A7a, 8/06/2021=
 =C3=A0(s)
> 17:50:
>
>> On 08.06.21 17:16, Jo=C3=A3o Costa wrote:
>> > I was able to move forward but I got stuck in this error when I tried =
to
>> > execute the latency test:
>> >
>> >     xxx@hypertests:/usr/lib/xenomai/testsuite$ ./latency
>> >        0"000.000| BUG in low_init(): [main] Cobalt core not enabled in
>> >     kernel
>> >
>> >
>> > I used the pre-patched kernel [1] and used the "instruction sequencing
>> > #1" presented below.
>> >
>> > I assumed that the cobalt kernel/support is already embedded/patched i=
n
>> > this pre-patched version. However, since the wiki points to the lack o=
f
>> > cobalt support [2], this assumption may not be correct and/or I may be
>> > missing some steps.
>> >
>> > What does the pre-patched kernel includes?
>> >
>>
>> Die Wiki is actually right: You do need to run the prepare script. If
>> the target kernel happens to already contain the I-pipe (or, soon,
>> dovetail) patch, that part of the preparation is automatically skipped.
>>
>> > As a shot in the dark, I also tried to enable the cobalt core (running
>> > the instructions below after decompressing the ipipe-x96*) but got stu=
ck
>> > when compiling and generating the debian packages (it just freezed
>> there)
>> >
>> >     $ cd xenomai-3.1/scripts/
>> >     $ ./prepare-kernel.sh
>> >     --linux=3D/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4--arch=3Dx86=
_64
>> >     --outpatch=3D/home/xxx/cobalt-core-3.1-5.4.105.patch
>> >     $ cd ~/ipipe-x86-ipipe-core-5.4.105-x86-4/
>> >     $ patch -p1 < ../cobalt-core-3.1-5.4.105.patch
>> >
>>
>> You can just run "./prepare-kernel.sh --linux=3D... --arch=3D...", no ne=
ed
>> to route out the cobalt patch first. Just like the wiki does.
>>
>> If you have improvement suggestions for the wiki, please fork the
>> project (https://source.denx.de/Xenomai/xenomai/-/wikis/git_access) and
>> submit patches against.
>>
>> Jan
>>
>> --
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
>>
>
