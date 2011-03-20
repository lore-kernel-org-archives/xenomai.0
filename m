MIME-Version: 1.0
In-Reply-To: <AANLkTin5j_zFQbzb6gh5uq_eETGh3wQO+pc+L87_nr7H@mail.gmail.com>
References: <mailman.25.1300532408.23962.xenomai@xenomai.org>
	<AANLkTimXw7wO=JzNNHDVtY_86R1qxLZjexVatmMPjoKw@domain.hid>
	<AANLkTin5j_zFQbzb6gh5uq_eETGh3wQO+pc+L87_nr7H@mail.gmail.com>
Date: Sun, 20 Mar 2011 19:11:09 +0800
Message-ID: <AANLkTinAocPYgZ7qdOmVYrKbqUu-BFT01Bqn=8BB221p@domain.hid>
From: alamo hwuang <lovealamo@domain.hid>
Content-Type: multipart/alternative; boundary=20cf305b0e027f32dc049ee81177
Subject: Re: [Xenomai-core] Xenomai-core Digest, Vol 66, Issue 9
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--20cf305b0e027f32dc049ee81177
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

I use all the cpu (0---7) in my application.

just like below.

rt_task_create(......,T_CPU(0));//the stack is 1M(1024*1024)

rt_task_create(......,T_CPU(1));//the stack is 64M(1024*1024*64)
rt_task_create(......,T_CPU(2));//the stack is 64M(1024*1024*64)

rt_task_create(......,T_CPU(3));//the stakc is 1M

rt_task_create(......,T_CPU(4));//the stack is 1M

rt_task_create(......,T_CPU(5));//the stack is 1M

rt_task_create(......,T_CPU(6));//the stack is 1M

rt_task_create(......,T_CPU(7));//the stack is 1M

please help me checking which the problem is!

thanks.



=D4=DA 2011=C4=EA3=D4=C220=C8=D5 =CF=C2=CE=E77:04=A3=ACalamo hwuang <loveal=
amo@domain.hid>=D0=B4=B5=C0=A3=BA

> The crash down infomation of strace tool is below
>
>
> strace ./APP_LTE_DEMO ../config.txt
> execve("./APP_LTE_DEMO", ["./APP_LTE_DEMO", "../config.txt"], [/* 92 vars
> */]) =3D 0
> brk(0)                                  =3D 0x159e4000
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D
> 0x7fe970d4b000
> access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or
> directory)
> open("/opt/intel/Compiler/11.1/072/lib/intel64/tls/x86_64/libstdc++.so.6"=
,
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/lib/intel64/tls/x86_64", 0x7fffdbbfe0a=
0)
> =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/lib/intel64/tls/libstdc++.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/lib/intel64/tls", 0x7fffdbbfe0a0) =3D =
-1
> ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/lib/intel64/x86_64/libstdc++.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/lib/intel64/x86_64", 0x7fffdbbfe0a0) =
=3D
> -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/lib/intel64/libstdc++.so.6", O_RDONLY)=
 =3D
> -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/lib/intel64", {st_mode=3DS_IFDIR|0755,
> st_size=3D4096, ...}) =3D 0
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/tls/x86_64/libstdc=
++.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/tls/x86_64",
> 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/tls/libstdc++.so.6=
",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/tls",
> 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/x86_64/libstdc++.s=
o.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/x86_64",
> 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libstdc++.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib",
> {st_mode=3DS_IFDIR|0755, st_size=3D12288, ...}) =3D 0
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/tls/x86_64/libstdc++.so.=
6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/tls/x86_64",
> 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/tls/libstdc++.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/tls", 0x7fffdbbfe0a0) =
=3D -1
> ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/x86_64/libstdc++.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/x86_64", 0x7fffdbbfe0a0)=
 =3D
> -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libstdc++.so.6", O_RDONL=
Y)
> =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/mkl/lib/em64t", {st_mode=3DS_IFDIR|075=
5,
> st_size=3D4096, ...}) =3D 0
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/tls/x86_64/libstdc++.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/tls/x86_64",
> 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/tls/libstdc++.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/tls",
> 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/x86_64/libstdc++.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/x86_64",
> 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/libstdc++.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> stat("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib",
> {st_mode=3DS_IFDIR|0755, st_size=3D4096, ...}) =3D 0
> open("/usr/xenomai/lib/tls/x86_64/libstdc++.so.6", O_RDONLY) =3D -1 ENOEN=
T
> (No such file or directory)
> stat("/usr/xenomai/lib/tls/x86_64", 0x7fffdbbfe0a0) =3D -1 ENOENT (No suc=
h
> file or directory)
> open("/usr/xenomai/lib/tls/libstdc++.so.6", O_RDONLY) =3D -1 ENOENT (No s=
uch
> file or directory)
> stat("/usr/xenomai/lib/tls", 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file =
or
> directory)
> open("/usr/xenomai/lib/x86_64/libstdc++.so.6", O_RDONLY) =3D -1 ENOENT (N=
o
> such file or directory)
> stat("/usr/xenomai/lib/x86_64", 0x7fffdbbfe0a0) =3D -1 ENOENT (No such fi=
le
> or directory)
> open("/usr/xenomai/lib/libstdc++.so.6", O_RDONLY) =3D -1 ENOENT (No such =
file
> or directory)
> stat("/usr/xenomai/lib", {st_mode=3DS_IFDIR|0755, st_size=3D4096, ...}) =
=3D 0
> open("tls/x86_64/libstdc++.so.6", O_RDONLY) =3D -1 ENOENT (No such file o=
r
> directory)
> open("tls/libstdc++.so.6", O_RDONLY)    =3D -1 ENOENT (No such file or
> directory)
> open("x86_64/libstdc++.so.6", O_RDONLY) =3D -1 ENOENT (No such file or
> directory)
> open("libstdc++.so.6", O_RDONLY)        =3D -1 ENOENT (No such file or
> directory)
> open("/usr/xenomai/lib/libstdc++.so.6", O_RDONLY) =3D -1 ENOENT (No such =
file
> or directory)
> open("/etc/ld.so.cache", O_RDONLY)      =3D 3
> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D228027, ...}) =3D 0
> mmap(NULL, 228027, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7fe970d13000
> close(3)                                =3D 0
> open("/usr/lib64/libstdc++.so.6", O_RDONLY) =3D 3
> read(3,
> "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360k\5\0\0\0\0\0"..., 832=
) =3D
> 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1015448, ...}) =3D 0
> mmap(NULL, 3187512, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D
> 0x7fe970823000
> fadvise64(3, 0, 3187512, POSIX_FADV_WILLNEED) =3D 0
> mprotect(0x7fe970913000, 2093056, PROT_NONE) =3D 0
> mmap(0x7fe970b12000, 36864, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xef000) =3D 0x7fe970b12000
> mmap(0x7fe970b1b000, 74552, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7fe970b1b000
> close(3)                                =3D 0
> open("/opt/intel/Compiler/11.1/072/lib/intel64/libxenomai.so.0", O_RDONLY=
)
> =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libxenomai.so.0",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libxenomai.so.0",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/libxenomai.so.0",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/usr/xenomai/lib/libxenomai.so.0", O_RDONLY) =3D 3
> read(3,
> "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\26\0\0\0\0\0\0"..., 83=
2)
> =3D 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D26455, ...}) =3D 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D
> 0x7fe970d12000
> mmap(NULL, 2114808, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D
> 0x7fe97061e000
> fadvise64(3, 0, 2114808, POSIX_FADV_WILLNEED) =3D 0
> mprotect(0x7fe970621000, 2097152, PROT_NONE) =3D 0
> mmap(0x7fe970821000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) =3D 0x7fe970821000
> close(3)                                =3D 0
> open("/opt/intel/Compiler/11.1/072/lib/intel64/libpthread.so.0", O_RDONLY=
)
> =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libpthread.so.0",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libpthread.so.0",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/libpthread.so.0",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/usr/xenomai/lib/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such
> file or directory)
> open("tls/x86_64/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such file =
or
> directory)
> open("tls/libpthread.so.0", O_RDONLY)   =3D -1 ENOENT (No such file or
> directory)
> open("x86_64/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such file or
> directory)
> open("libpthread.so.0", O_RDONLY)       =3D -1 ENOENT (No such file or
> directory)
> open("/usr/xenomai/lib/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such
> file or directory)
> open("/lib64/libpthread.so.0", O_RDONLY) =3D 3
> read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@domain.hid"...=
,
> 832) =3D 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D135646, ...}) =3D 0
> mmap(NULL, 2212736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D
> 0x7fe970401000
> fadvise64(3, 0, 2212736, POSIX_FADV_WILLNEED) =3D 0
> mprotect(0x7fe970418000, 2097152, PROT_NONE) =3D 0
> mmap(0x7fe970618000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17000) =3D 0x7fe970618000
> mmap(0x7fe97061a000, 13184, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7fe97061a000
> close(3)                                =3D 0
> open("/opt/intel/Compiler/11.1/072/lib/intel64/libnative.so.3", O_RDONLY)=
 =3D
> -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libnative.so.3",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libnative.so.3", O_RDONL=
Y)
> =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/libnative.so.3",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/usr/xenomai/lib/libnative.so.3", O_RDONLY) =3D 3
> read(3,
> "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\2201\0\0\0\0\0\0"..., 832=
) =3D
> 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D53279, ...}) =3D 0
> mmap(NULL, 2138512, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D
> 0x7fe9701f6000
> fadvise64(3, 0, 2138512, POSIX_FADV_WILLNEED) =3D 0
> mprotect(0x7fe970200000, 2093056, PROT_NONE) =3D 0
> mmap(0x7fe9703ff000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9000) =3D 0x7fe9703ff000
> close(3)                                =3D 0
> open("/opt/intel/Compiler/11.1/072/lib/intel64/libm.so.6", O_RDONLY) =3D =
-1
> ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libm.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libm.so.6", O_RDONLY) =
=3D -1
> ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/libm.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/usr/xenomai/lib/libm.so.6", O_RDONLY) =3D -1 ENOENT (No such file =
or
> directory)
> open("tls/x86_64/libm.so.6", O_RDONLY)  =3D -1 ENOENT (No such file or
> directory)
> open("tls/libm.so.6", O_RDONLY)         =3D -1 ENOENT (No such file or
> directory)
> open("x86_64/libm.so.6", O_RDONLY)      =3D -1 ENOENT (No such file or
> directory)
> open("libm.so.6", O_RDONLY)             =3D -1 ENOENT (No such file or
> directory)
> open("/usr/xenomai/lib/libm.so.6", O_RDONLY) =3D -1 ENOENT (No such file =
or
> directory)
> open("/lib64/libm.so.6", O_RDONLY)      =3D 3
> read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`>\0\0\0\0\0\0"...=
,
> 832) =3D 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D388274, ...}) =3D 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D
> 0x7fe970d11000
> mmap(NULL, 2445496, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D
> 0x7fe96ffa0000
> fadvise64(3, 0, 2445496, POSIX_FADV_WILLNEED) =3D 0
> mprotect(0x7fe96fff5000, 2093056, PROT_NONE) =3D 0
> mmap(0x7fe9701f4000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x54000) =3D 0x7fe9701f4000
> close(3)                                =3D 0
> open("/opt/intel/Compiler/11.1/072/lib/intel64/libgcc_s.so.1", O_RDONLY) =
=3D
> -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libgcc_s.so.1",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libgcc_s.so.1", O_RDONLY=
)
> =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/libgcc_s.so.1",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/usr/xenomai/lib/libgcc_s.so.1", O_RDONLY) =3D -1 ENOENT (No such f=
ile
> or directory)
> open("tls/x86_64/libgcc_s.so.1", O_RDONLY) =3D -1 ENOENT (No such file or
> directory)
> open("tls/libgcc_s.so.1", O_RDONLY)     =3D -1 ENOENT (No such file or
> directory)
> open("x86_64/libgcc_s.so.1", O_RDONLY)  =3D -1 ENOENT (No such file or
> directory)
> open("libgcc_s.so.1", O_RDONLY)         =3D -1 ENOENT (No such file or
> directory)
> open("/usr/xenomai/lib/libgcc_s.so.1", O_RDONLY) =3D -1 ENOENT (No such f=
ile
> or directory)
> open("/lib64/libgcc_s.so.1", O_RDONLY)  =3D 3
> read(3,
> "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\300,\0\0\0\0\0\0"..., 832=
) =3D
> 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D92648, ...}) =3D 0
> mmap(NULL, 2188280, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D
> 0x7fe96fd89000
> fadvise64(3, 0, 2188280, POSIX_FADV_WILLNEED) =3D 0
> mprotect(0x7fe96fd9f000, 2093056, PROT_NONE) =3D 0
> mmap(0x7fe96ff9e000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15000) =3D 0x7fe96ff9e000
> close(3)                                =3D 0
> open("/opt/intel/Compiler/11.1/072/lib/intel64/libc.so.6", O_RDONLY) =3D =
-1
> ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libc.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libc.so.6", O_RDONLY) =
=3D -1
> ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/libc.so.6",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/usr/xenomai/lib/libc.so.6", O_RDONLY) =3D -1 ENOENT (No such file =
or
> directory)
> open("tls/x86_64/libc.so.6", O_RDONLY)  =3D -1 ENOENT (No such file or
> directory)
> open("tls/libc.so.6", O_RDONLY)         =3D -1 ENOENT (No such file or
> directory)
> open("x86_64/libc.so.6", O_RDONLY)      =3D -1 ENOENT (No such file or
> directory)
> open("libc.so.6", O_RDONLY)             =3D -1 ENOENT (No such file or
> directory)
> open("/usr/xenomai/lib/libc.so.6", O_RDONLY) =3D -1 ENOENT (No such file =
or
> directory)
> open("/lib64/libc.so.6", O_RDONLY)      =3D 3
> read(3,
> "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\340\354\1\0\0\0\0\0"...,
> 832) =3D 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1661454, ...}) =3D 0
> mmap(NULL, 3528776, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D
> 0x7fe96fa2b000
> fadvise64(3, 0, 3528776, POSIX_FADV_WILLNEED) =3D 0
> mprotect(0x7fe96fb7f000, 2097152, PROT_NONE) =3D 0
> mmap(0x7fe96fd7f000, 20480, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x154000) =3D 0x7fe96fd7f000
> mmap(0x7fe96fd84000, 18504, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7fe96fd84000
> close(3)                                =3D 0
> open("/opt/intel/Compiler/11.1/072/lib/intel64/libdl.so.2", O_RDONLY) =3D=
 -1
> ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libdl.so.2",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libdl.so.2", O_RDONLY) =
=3D
> -1 ENOENT (No such file or directory)
> open("/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.=
16.21/lib/libdl.so.2",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> open("/usr/xenomai/lib/libdl.so.2", O_RDONLY) =3D -1 ENOENT (No such file=
 or
> directory)
> open("tls/x86_64/libdl.so.2", O_RDONLY) =3D -1 ENOENT (No such file or
> directory)
> open("tls/libdl.so.2", O_RDONLY)        =3D -1 ENOENT (No such file or
> directory)
> open("x86_64/libdl.so.2", O_RDONLY)     =3D -1 ENOENT (No such file or
> directory)
> open("libdl.so.2", O_RDONLY)            =3D -1 ENOENT (No such file or
> directory)
> open("/usr/xenomai/lib/libdl.so.2", O_RDONLY) =3D -1 ENOENT (No such file=
 or
> directory)
> open("/lib64/libdl.so.2", O_RDONLY)     =3D 3
> read(3,
> "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360\r\0\0\0\0\0\0"..., 83=
2)
> =3D 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D19114, ...}) =3D 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D
> 0x7fe970d10000
> mmap(NULL, 2109696, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D
> 0x7fe96f827000
> fadvise64(3, 0, 2109696, POSIX_FADV_WILLNEED) =3D 0
> mprotect(0x7fe96f829000, 2097152, PROT_NONE) =3D 0
> mmap(0x7fe96fa29000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) =3D 0x7fe96fa29000
> close(3)                                =3D 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D
> 0x7fe970d0f000
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D
> 0x7fe970d0d000
> arch_prctl(ARCH_SET_FS, 0x7fe970d0d720) =3D 0
> mprotect(0x7fe96fa29000, 4096, PROT_READ) =3D 0
> mprotect(0x7fe96fd7f000, 16384, PROT_READ) =3D 0
> mprotect(0x7fe96ff9e000, 4096, PROT_READ) =3D 0
> mprotect(0x7fe9701f4000, 4096, PROT_READ) =3D 0
> mprotect(0x7fe9703ff000, 4096, PROT_READ) =3D 0
> mprotect(0x7fe970618000, 4096, PROT_READ) =3D 0
> mprotect(0x7fe970821000, 4096, PROT_READ) =3D 0
> mprotect(0x7fe970b12000, 28672, PROT_READ) =3D 0
> mprotect(0x72e000, 4096, PROT_READ)     =3D 0
> mprotect(0x7fe970d4c000, 4096, PROT_READ) =3D 0
> munmap(0x7fe970d13000, 228027)          =3D 0
> set_tid_address(0x7fe970d0d9f0)         =3D 7836
> set_robust_list(0x7fe970d0da00, 0x18)   =3D 0
> futex(0x7fffdbbfe96c, FUTEX_WAKE_PRIVATE, 1) =3D 0
> futex(0x7fffdbbfe96c, 0x189 /* FUTEX_??? */, 1, NULL, 7fe970d0d720) =3D -=
1
> EAGAIN (Resource temporarily unavailable)
> rt_sigaction(SIGRTMIN, {0x7fe9704068b0, [], SA_RESTORER|SA_SIGINFO,
> 0x7fe9704105d0}, NULL, 8) =3D 0
> rt_sigaction(SIGRT_1, {0x7fe970406940, [],
> SA_RESTORER|SA_RESTART|SA_SIGINFO, 0x7fe9704105d0}, NULL, 8) =3D 0
> rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) =3D 0
> getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, rlim_max=3DRLIM_INFINITY})=
 =3D 0
> access("/dev/rtheap", F_OK)             =3D 0
> rt_sigaction(SIGILL, {0x7fe97061f7b0, [ILL], SA_RESTORER|SA_RESTART,
> 0x7fe96fa5d9e0}, {SIG_DFL, [], 0}, 8) =3D 0
> rt_sigaction(SIGILL, {SIG_DFL, [ILL], SA_RESTORER|SA_RESTART,
> 0x7fe96fa5d9e0}, {0x7fe97061f7b0, [ILL], SA_RESTORER|SA_RESTART,
> 0x7fe96fa5d9e0}, 8) =3D 0
> open("/dev/rtheap", O_RDWR)             =3D 3
> ioctl(3, 0, 0xffff8800dc5e5428)         =3D 0
> mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =3D 0x7fe970d47=
000
> close(3)                                =3D 0
> futex(0x7fe9708223a0, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
> open("/dev/rtheap", O_RDWR)             =3D 3
> ioctl(3, 0, 0xffffffff81b28838)         =3D 0
> mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =3D 0x7fe970d44=
000
> close(3)                                =3D 0
> futex(0x7fe9708223a4, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
> futex(0x7fe970822260, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
> futex(0x7fe970822340, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
> rt_sigaction(SIGXCPU, {0x7fe97061f7e0, [], SA_RESTORER|SA_SIGINFO,
> 0x7fe9704105d0}, NULL, 8) =3D 0
> brk(0)                                  =3D 0x159e4000
> brk(0x15a05000)                         =3D 0x15a05000
> open("../config.txt", O_RDONLY)         =3D 3
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D125, ...}) =3D 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D
> 0x7fe970d43000
> read(3, "eth0 C8:0A:A9:11:A7:DF\r\neth1 00:"..., 4096) =3D 125
> open("/root/stats/stats.xml", O_RDWR|O_CREAT|O_APPEND, 0666) =3D -1 ENOEN=
T
> (No such file or directory)
> open("/root/stats/ctrl.txt", O_RDWR|O_CREAT|O_TRUNC, 0666) =3D -1 ENOENT =
(No
> such file or directory)
> read(3, "", 4096)                       =3D 0
> close(3)                                =3D 0
> munmap(0x7fe970d43000, 4096)            =3D 0
> socket(PF_PACKET, SOCK_RAW, 8)          =3D 3
> socket(PF_PACKET, SOCK_RAW, 768)        =3D 4
> ioctl(3, SIOCGIFINDEX, {ifr_name=3D"eth0", ifr_index=3D2}) =3D 0
> bind(3, {sa_family=3DAF_PACKET, proto=3D0x800, if2, pkttype=3DPACKET_HOST=
,
> addr(0)=3D{0, }, 20) =3D 0
> ioctl(3, SIOCGIFFLAGS, {ifr_name=3D"eth0",
> ifr_flags=3DIFF_UP|IFF_BROADCAST|IFF_RUNNING|IFF_PROMISC|IFF_MULTICAST}) =
=3D 0
> ioctl(3, SIOCSIFFLAGS, 0x7fffdbbfe740)  =3D 0
> ioctl(3, SIOCGIFINDEX, {ifr_name=3D"eth0", ifr_index=3D2}) =3D 0
> ioctl(4, SIOCGIFINDEX, {ifr_name=3D"eth1", ifr_index=3D3}) =3D 0
> mmap(NULL, 491524096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1=
,
> 0) =3D 0x7fe952366000
> fstat(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(136, 1), ...}) =3D 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D
> 0x7fe970d43000
> write(1, "Noise Generated\n", 16Noise Generated
> )       =3D 16
> mlockall(MCL_CURRENT|MCL_FUTURE)        =3D 0
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> mmap(NULL, 1052672, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe970c0c000
> mprotect(0x7fe970c0c000, 4096, PROT_NONE) =3D 0
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> clone(child_stack=3D0x7fe970d0bfd0,
> flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SY=
SVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=3D0x7fe970d0c9e0, tls=3D0x7fe970d0c710,
> child_tidptr=3D0x7fe970d0c9e0) =3D 7837
> sched_setscheduler(7837, SCHED_FIFO, { 22 }) =3D 0
> futex(0x7fe970d0cd28, FUTEX_WAKE_PRIVATE, 1) =3D 1
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> mmap(NULL, 1052672, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe952265000
> mprotect(0x7fe952265000, 4096, PROT_NONE) =3D 0
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> clone(child_stack=3D0x7fe952364fd0,
> flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SY=
SVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=3D0x7fe9523659e0, tls=3D0x7fe952365710,
> child_tidptr=3D0x7fe9523659e0) =3D 7838
> sched_setscheduler(7838, SCHED_FIFO, { 23 }) =3D 0
> futex(0x7fe952365d28, FUTEX_WAKE_PRIVATE, 1) =3D 1
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> mmap(NULL, 1052672, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe952164000
> mprotect(0x7fe952164000, 4096, PROT_NONE) =3D 0
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> clone(child_stack=3D0x7fe952263fd0,
> flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SY=
SVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=3D0x7fe9522649e0, tls=3D0x7fe952264710,
> child_tidptr=3D0x7fe9522649e0) =3D 7839
> sched_setscheduler(7839, SCHED_FIFO, { 20 }) =3D 0
> futex(0x7fe952264d28, FUTEX_WAKE_PRIVATE, 1) =3D 1
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> mmap(NULL, 1052672, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe952063000
> mprotect(0x7fe952063000, 4096, PROT_NONE) =3D 0
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> clone(child_stack=3D0x7fe952162fd0,
> flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SY=
SVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=3D0x7fe9521639e0, tls=3D0x7fe952163710,
> child_tidptr=3D0x7fe9521639e0) =3D 7840
> sched_setscheduler(7840, SCHED_FIFO, { 21 }) =3D 0
> futex(0x7fe952163d28, FUTEX_WAKE_PRIVATE, 1) =3D 1
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> mmap(NULL, 1052672, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe951f62000
> mprotect(0x7fe951f62000, 4096, PROT_NONE) =3D 0
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> clone(child_stack=3D0x7fe952061fd0,
> flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SY=
SVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=3D0x7fe9520629e0, tls=3D0x7fe952062710,
> child_tidptr=3D0x7fe9520629e0) =3D 7841
> sched_setscheduler(7841, SCHED_FIFO, { 30 }) =3D 0
> futex(0x7fe952062d28, FUTEX_WAKE_PRIVATE, 1) =3D 1
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> mmap(NULL, 67112960, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe94df61000
> mprotect(0x7fe94df61000, 4096, PROT_NONE) =3D 0
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> clone(child_stack=3D0x7fe951f60fd0,
> flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SY=
SVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=3D0x7fe951f619e0, tls=3D0x7fe951f61710,
> child_tidptr=3D0x7fe951f619e0) =3D 7842
> sched_setscheduler(7842, SCHED_FIFO, { 31 }) =3D 0
> futex(0x7fe951f61d28, FUTEX_WAKE_PRIVATE, 1) =3D 1
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> mmap(NULL, 69632, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe970d32000
> mprotect(0x7fe970d32000, 4096, PROT_NONE) =3D 0
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> clone(child_stack=3D0x7fe970d41fd0,
> flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SY=
SVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=3D0x7fe970d429e0, tls=3D0x7fe970d42710,
> child_tidptr=3D0x7fe970d429e0) =3D 7843
> sched_setscheduler(7843, SCHED_FIFO, { 15 }) =3D 0
> futex(0x7fe970d42d28, FUTEX_WAKE_PRIVATE, 1) =3D 1
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> mmap(NULL, 69632, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe970d21000
> mprotect(0x7fe970d21000, 4096, PROT_NONE) =3D 0
> sched_get_priority_min(SCHED_FIFO)      =3D 1
> sched_get_priority_max(SCHED_FIFO)      =3D 99
> clone(child_stack=3D0x7fe970d30fd0,
> flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SY=
SVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=3D0x7fe970d319e0, tls=3D0x7fe970d31710,
> child_tidptr=3D0x7fe970d319e0) =3D 7844
> sched_setscheduler(7844, SCHED_FIFO, { 10 }) =3D 0
> futex(0x7fe970d31d28, FUTEX_WAKE_PRIVATE, 1) =3D 1
> futex(0x7fe970d319e0, FUTEX_WAIT, 7844, NULL <unfinished ...>
> +++ killed by SIGSEGV +++
>
>
>
> Can you help me to find the problem?
>
>
> The problem persists in the (kernel 2.6.34.5 with xenomai 2.5.4) and
> (kernel 2.6.34.5 with xenomai 2.5.6) and (kernel 2.6.37 with xenomai 2.5.=
6).
> the configure file .config are all the same. like above file.
>
> Thanks.
>
>
>
>
>
>
>
>
>
>
> =D4=DA 2011=C4=EA3=D4=C220=C8=D5 =CF=C2=CE=E76:56=A3=ACalamo hwuang <love=
alamo@domain.hid>=D0=B4=B5=C0=A3=BA
>
> Hi Gilles
>>
>> The error of "c:929:error implicit declaration of function
>> "set_cpus_allowed""  is handed by me. But I didn't know the reason. I
>> just  uncheck the item "enable maximum number of smp processor and numa
>> nodes" and sign the maximum number of CPU as 8(maximum number of cpus).
>> after that it can make and no error.
>>
>> But there is another huge problems . My application will segmant failt
>> every time in the xenomai paltfrom. The detail as below.
>>
>> cpu:i7 2600 (sandy bridge)
>>
>> the linux kernel linux-2.6.34.5
>> xenomai package:xenomai 2.5.4
>>
>> the config file is :
>>
>> #
>> # Automatically generated make config: don't edit
>> # Linux kernel version: 2.6.34.5
>> # Thu Oct  7 17:10:41 2010
>> #
>> CONFIG_64BIT=3Dy
>> # CONFIG_X86_32 is not set
>> CONFIG_X86_64=3Dy
>> CONFIG_X86=3Dy
>> CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
>> CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/x86_64_defconfig"
>> CONFIG_GENERIC_TIME=3Dy
>> CONFIG_GENERIC_CMOS_UPDATE=3Dy
>> CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
>> CONFIG_GENERIC_CLOCKEVENTS=3Dy
>> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
>> CONFIG_LOCKDEP_SUPPORT=3Dy
>> CONFIG_STACKTRACE_SUPPORT=3Dy
>> CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
>> CONFIG_MMU=3Dy
>> CONFIG_ZONE_DMA=3Dy
>> CONFIG_NEED_DMA_MAP_STATE=3Dy
>> CONFIG_GENERIC_ISA_DMA=3Dy
>> CONFIG_GENERIC_IOMAP=3Dy
>> CONFIG_GENERIC_BUG=3Dy
>> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
>> CONFIG_GENERIC_HWEIGHT=3Dy
>> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
>> # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
>> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
>> CONFIG_ARCH_HAS_CPU_IDLE_WAIT=3Dy
>> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
>> CONFIG_GENERIC_TIME_VSYSCALL=3Dy
>> CONFIG_ARCH_HAS_CPU_RELAX=3Dy
>> CONFIG_ARCH_HAS_DEFAULT_IDLE=3Dy
>> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
>> CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
>> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
>> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
>> CONFIG_HAVE_CPUMASK_OF_CPU_MAP=3Dy
>> CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
>> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
>> CONFIG_ZONE_DMA32=3Dy
>> CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
>> CONFIG_AUDIT_ARCH=3Dy
>> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy
>> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
>> CONFIG_HAVE_EARLY_RES=3Dy
>> CONFIG_HAVE_INTEL_TXT=3Dy
>> CONFIG_GENERIC_HARDIRQS=3Dy
>> CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy
>> CONFIG_GENERIC_IRQ_PROBE=3Dy
>> CONFIG_GENERIC_PENDING_IRQ=3Dy
>> CONFIG_USE_GENERIC_SMP_HELPERS=3Dy
>> CONFIG_X86_64_SMP=3Dy
>> CONFIG_X86_HT=3Dy
>> CONFIG_X86_TRAMPOLINE=3Dy
>> # CONFIG_KTIME_SCALAR is not set
>> CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
>> CONFIG_CONSTRUCTORS=3Dy
>>
>> #
>> # General setup
>> #
>> CONFIG_EXPERIMENTAL=3Dy
>> CONFIG_LOCK_KERNEL=3Dy
>> CONFIG_INIT_ENV_ARG_LIMIT=3D32
>> CONFIG_LOCALVERSION=3D""
>> # CONFIG_LOCALVERSION_AUTO is not set
>> CONFIG_HAVE_KERNEL_GZIP=3Dy
>> CONFIG_HAVE_KERNEL_BZIP2=3Dy
>> CONFIG_HAVE_KERNEL_LZMA=3Dy
>> CONFIG_HAVE_KERNEL_LZO=3Dy
>> CONFIG_KERNEL_GZIP=3Dy
>> # CONFIG_KERNEL_BZIP2 is not set
>> # CONFIG_KERNEL_LZMA is not set
>> # CONFIG_KERNEL_LZO is not set
>> CONFIG_SWAP=3Dy
>> CONFIG_SYSVIPC=3Dy
>> CONFIG_SYSVIPC_SYSCTL=3Dy
>> CONFIG_POSIX_MQUEUE=3Dy
>> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
>> CONFIG_BSD_PROCESS_ACCT=3Dy
>> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
>> CONFIG_TASKSTATS=3Dy
>> CONFIG_TASK_DELAY_ACCT=3Dy
>> CONFIG_TASK_XACCT=3Dy
>> CONFIG_TASK_IO_ACCOUNTING=3Dy
>> CONFIG_AUDIT=3Dy
>> CONFIG_AUDITSYSCALL=3Dy
>> CONFIG_AUDIT_TREE=3Dy
>>
>> #
>> # RCU Subsystem
>> #
>> CONFIG_TREE_RCU=3Dy
>> # CONFIG_TREE_PREEMPT_RCU is not set
>> # CONFIG_TINY_RCU is not set
>> # CONFIG_RCU_TRACE is not set
>> CONFIG_RCU_FANOUT=3D64
>> # CONFIG_RCU_FANOUT_EXACT is not set
>> # CONFIG_RCU_FAST_NO_HZ is not set
>> # CONFIG_TREE_RCU_TRACE is not set
>> # CONFIG_IKCONFIG is not set
>> CONFIG_LOG_BUF_SHIFT=3D17
>> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
>> CONFIG_CGROUPS=3Dy
>> # CONFIG_CGROUP_DEBUG is not set
>> CONFIG_CGROUP_NS=3Dy
>> CONFIG_CGROUP_FREEZER=3Dy
>> CONFIG_CGROUP_DEVICE=3Dy
>> CONFIG_CPUSETS=3Dy
>> CONFIG_PROC_PID_CPUSET=3Dy
>> CONFIG_CGROUP_CPUACCT=3Dy
>> CONFIG_RESOURCE_COUNTERS=3Dy
>> CONFIG_CGROUP_MEM_RES_CTLR=3Dy
>> CONFIG_CGROUP_MEM_RES_CTLR_SWAP=3Dy
>> CONFIG_CGROUP_SCHED=3Dy
>> CONFIG_FAIR_GROUP_SCHED=3Dy
>> CONFIG_RT_GROUP_SCHED=3Dy
>> CONFIG_MM_OWNER=3Dy
>> # CONFIG_SYSFS_DEPRECATED_V2 is not set
>> CONFIG_RELAY=3Dy
>> CONFIG_NAMESPACES=3Dy
>> CONFIG_UTS_NS=3Dy
>> CONFIG_IPC_NS=3Dy
>> CONFIG_USER_NS=3Dy
>> CONFIG_PID_NS=3Dy
>> CONFIG_NET_NS=3Dy
>> CONFIG_BLK_DEV_INITRD=3Dy
>> CONFIG_INITRAMFS_SOURCE=3D""
>> CONFIG_RD_GZIP=3Dy
>> CONFIG_RD_BZIP2=3Dy
>> CONFIG_RD_LZMA=3Dy
>> CONFIG_RD_LZO=3Dy
>> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
>> CONFIG_SYSCTL=3Dy
>> CONFIG_ANON_INODES=3Dy
>> # CONFIG_EMBEDDED is not set
>> CONFIG_UID16=3Dy
>> CONFIG_SYSCTL_SYSCALL=3Dy
>> CONFIG_KALLSYMS=3Dy
>> CONFIG_KALLSYMS_ALL=3Dy
>> CONFIG_KALLSYMS_EXTRA_PASS=3Dy
>> CONFIG_HOTPLUG=3Dy
>> CONFIG_PRINTK=3Dy
>> CONFIG_BUG=3Dy
>> CONFIG_ELF_CORE=3Dy
>> CONFIG_PCSPKR_PLATFORM=3Dy
>> CONFIG_BASE_FULL=3Dy
>> CONFIG_FUTEX=3Dy
>> CONFIG_EPOLL=3Dy
>> CONFIG_SIGNALFD=3Dy
>> CONFIG_TIMERFD=3Dy
>> CONFIG_EVENTFD=3Dy
>> CONFIG_SHMEM=3Dy
>> CONFIG_AIO=3Dy
>> CONFIG_HAVE_PERF_EVENTS=3Dy
>>
>> #
>> # Kernel Performance Events And Counters
>> #
>> CONFIG_PERF_EVENTS=3Dy
>> # CONFIG_PERF_COUNTERS is not set
>> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
>> CONFIG_VM_EVENT_COUNTERS=3Dy
>> CONFIG_PCI_QUIRKS=3Dy
>> CONFIG_SLUB_DEBUG=3Dy
>> # CONFIG_COMPAT_BRK is not set
>> # CONFIG_SLAB is not set
>> CONFIG_SLUB=3Dy
>> # CONFIG_SLOB is not set
>> CONFIG_PROFILING=3Dy
>> CONFIG_TRACEPOINTS=3Dy
>> CONFIG_OPROFILE=3Dm
>> # CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
>> CONFIG_HAVE_OPROFILE=3Dy
>> CONFIG_KPROBES=3Dy
>> CONFIG_OPTPROBES=3Dy
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
>> CONFIG_KRETPROBES=3Dy
>> CONFIG_HAVE_IOREMAP_PROT=3Dy
>> CONFIG_HAVE_KPROBES=3Dy
>> CONFIG_HAVE_KRETPROBES=3Dy
>> CONFIG_HAVE_OPTPROBES=3Dy
>> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
>> CONFIG_HAVE_DMA_ATTRS=3Dy
>> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
>> CONFIG_HAVE_DMA_API_DEBUG=3Dy
>> CONFIG_HAVE_HW_BREAKPOINT=3Dy
>> CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
>>
>> #
>> # GCOV-based kernel profiling
>> #
>> # CONFIG_GCOV_KERNEL is not set
>> CONFIG_SLOW_WORK=3Dy
>> # CONFIG_SLOW_WORK_DEBUG is not set
>> # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
>> CONFIG_SLABINFO=3Dy
>> CONFIG_RT_MUTEXES=3Dy
>> CONFIG_BASE_SMALL=3D0
>> CONFIG_MODULES=3Dy
>> # CONFIG_MODULE_FORCE_LOAD is not set
>> CONFIG_MODULE_UNLOAD=3Dy
>> # CONFIG_MODULE_FORCE_UNLOAD is not set
>> # CONFIG_MODVERSIONS is not set
>> CONFIG_MODULE_SRCVERSION_ALL=3Dy
>> CONFIG_STOP_MACHINE=3Dy
>> CONFIG_BLOCK=3Dy
>> CONFIG_BLK_DEV_BSG=3Dy
>> CONFIG_BLK_DEV_INTEGRITY=3Dy
>> CONFIG_BLOCK_COMPAT=3Dy
>>
>> #
>> # IO Schedulers
>> #
>> CONFIG_IOSCHED_NOOP=3Dy
>> CONFIG_IOSCHED_DEADLINE=3Dy
>> CONFIG_IOSCHED_CFQ=3Dy
>> # CONFIG_CFQ_GROUP_IOSCHED is not set
>> CONFIG_DEFAULT_DEADLINE=3Dy
>> # CONFIG_DEFAULT_CFQ is not set
>> # CONFIG_DEFAULT_NOOP is not set
>> CONFIG_DEFAULT_IOSCHED=3D"deadline"
>> # CONFIG_INLINE_SPIN_TRYLOCK is not set
>> # CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
>> # CONFIG_INLINE_SPIN_LOCK is not set
>> # CONFIG_INLINE_SPIN_LOCK_BH is not set
>> # CONFIG_INLINE_SPIN_LOCK_IRQ is not set
>> # CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
>> CONFIG_INLINE_SPIN_UNLOCK=3Dy
>> # CONFIG_INLINE_SPIN_UNLOCK_BH is not set
>> CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
>> # CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
>> # CONFIG_INLINE_READ_TRYLOCK is not set
>> # CONFIG_INLINE_READ_LOCK is not set
>> # CONFIG_INLINE_READ_LOCK_BH is not set
>> # CONFIG_INLINE_READ_LOCK_IRQ is not set
>> # CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
>> CONFIG_INLINE_READ_UNLOCK=3Dy
>> # CONFIG_INLINE_READ_UNLOCK_BH is not set
>> CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
>> # CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
>> # CONFIG_INLINE_WRITE_TRYLOCK is not set
>> # CONFIG_INLINE_WRITE_LOCK is not set
>> # CONFIG_INLINE_WRITE_LOCK_BH is not set
>> # CONFIG_INLINE_WRITE_LOCK_IRQ is not set
>> # CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
>> CONFIG_INLINE_WRITE_UNLOCK=3Dy
>> # CONFIG_INLINE_WRITE_UNLOCK_BH is not set
>> CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
>> # CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
>> CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
>>
>> #
>> # Real-time sub-system
>> #
>> CONFIG_XENOMAI=3Dy
>> CONFIG_XENO_GENERIC_STACKPOOL=3Dy
>> CONFIG_XENO_FASTSYNCH=3Dy
>> CONFIG_XENO_OPT_NUCLEUS=3Dy
>> CONFIG_XENO_OPT_PERVASIVE=3Dy
>> CONFIG_XENO_OPT_PRIOCPL=3Dy
>> CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy
>> # CONFIG_XENO_OPT_SCHED_CLASSES is not set
>> CONFIG_XENO_OPT_PIPE=3Dy
>> CONFIG_XENO_OPT_MAP=3Dy
>> CONFIG_XENO_OPT_PIPE_NRDEV=3D32
>> CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512
>> CONFIG_XENO_OPT_SYS_HEAPSZ=3D256
>> CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D128
>> CONFIG_XENO_OPT_SEM_HEAPSZ=3D12
>> CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=3D12
>> CONFIG_XENO_OPT_STATS=3Dy
>> # CONFIG_XENO_OPT_DEBUG is not set
>> CONFIG_XENO_OPT_SHIRQ=3Dy
>> CONFIG_XENO_OPT_SELECT=3Dy
>>
>> #
>> # Timing
>> #
>> # CONFIG_XENO_OPT_TIMING_PERIODIC is not set
>> CONFIG_XENO_OPT_TIMING_VIRTICK=3D1000
>> CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0
>>
>> #
>> # Scalability
>> #
>> # CONFIG_XENO_OPT_SCALABLE_SCHED is not set
>> CONFIG_XENO_OPT_TIMER_LIST=3Dy
>> # CONFIG_XENO_OPT_TIMER_HEAP is not set
>> # CONFIG_XENO_OPT_TIMER_WHEEL is not set
>>
>> #
>> # Machine
>> #
>> CONFIG_XENO_HW_FPU=3Dy
>>
>> #
>> # NMI watchdog
>> #
>> # CONFIG_XENO_HW_NMI_DEBUG_LATENCY is not set
>>
>> #
>> # SMI workaround
>> #
>> # CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
>> CONFIG_XENO_HW_SMI_DETECT=3Dy
>> CONFIG_XENO_HW_SMI_WORKAROUND=3Dy
>> CONFIG_XENO_HW_SMI_ALL=3Dy
>>
>> #
>> # Interfaces
>> #
>> CONFIG_XENO_SKIN_NATIVE=3Dy
>> CONFIG_XENO_OPT_NATIVE_PERIOD=3D0
>> CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
>> CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024
>> CONFIG_XENO_OPT_NATIVE_SEM=3Dy
>> CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
>> CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
>> CONFIG_XENO_OPT_NATIVE_COND=3Dy
>> CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
>> CONFIG_XENO_OPT_NATIVE_BUFFER=3Dy
>> CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
>> CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
>> CONFIG_XENO_OPT_NATIVE_MPS=3Dy
>> CONFIG_XENO_OPT_NATIVE_INTR=3Dy
>> CONFIG_XENO_SKIN_POSIX=3Dy
>> CONFIG_XENO_OPT_POSIX_PERIOD=3D0
>> CONFIG_XENO_OPT_POSIX_SHM=3Dy
>> CONFIG_XENO_OPT_POSIX_INTR=3Dy
>> CONFIG_XENO_OPT_POSIX_SELECT=3Dy
>> # CONFIG_XENO_OPT_DEBUG_POSIX is not set
>> # CONFIG_XENO_SKIN_PSOS is not set
>> # CONFIG_XENO_SKIN_UITRON is not set
>> # CONFIG_XENO_SKIN_VRTX is not set
>> # CONFIG_XENO_SKIN_VXWORKS is not set
>> # CONFIG_XENO_SKIN_RTAI is not set
>> # CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
>> CONFIG_XENO_SKIN_RTDM=3Dy
>> CONFIG_XENO_OPT_RTDM_PERIOD=3D0
>> CONFIG_XENO_OPT_RTDM_FILDES=3D128
>> CONFIG_XENO_OPT_RTDM_SELECT=3Dy
>>
>> #
>> # Drivers
>> #
>>
>> #
>> # Serial drivers
>> #
>> # CONFIG_XENO_DRIVERS_16550A is not set
>>
>> #
>> # Testing drivers
>> #
>> # CONFIG_XENO_DRIVERS_TESTING_LEGACY_NAMES is not set
>> CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy
>> # CONFIG_XENO_DRIVERS_KLATENCY is not set
>> # CONFIG_XENO_DRIVERS_IRQBENCH is not set
>> CONFIG_XENO_DRIVERS_SWITCHTEST=3Dy
>> # CONFIG_XENO_DRIVERS_SIGTEST is not set
>> # CONFIG_XENO_DRIVERS_RTDMTEST is not set
>>
>> #
>> # CAN drivers
>> #
>> # CONFIG_XENO_DRIVERS_CAN is not set
>>
>> #
>> # ANALOGY drivers
>> #
>> # CONFIG_XENO_DRIVERS_ANALOGY is not set
>>
>> #
>> # Real-time IPC drivers
>> #
>> CONFIG_XENO_DRIVERS_RTIPC=3Dm
>> CONFIG_XENO_DRIVERS_RTIPC_XDDP=3Dy
>> CONFIG_XENO_DRIVERS_RTIPC_IDDP=3Dy
>> CONFIG_XENO_OPT_IDDP_NRPORT=3D32
>> CONFIG_XENO_DRIVERS_RTIPC_BUFP=3Dy
>> CONFIG_XENO_OPT_BUFP_NRPORT=3D32
>> CONFIG_FREEZER=3Dy
>>
>> #
>> # Processor type and features
>> #
>> CONFIG_TICK_ONESHOT=3Dy
>> CONFIG_NO_HZ=3Dy
>> # CONFIG_HIGH_RES_TIMERS is not set
>> CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
>> CONFIG_SMP=3Dy
>> # CONFIG_X86_X2APIC is not set
>> # CONFIG_SPARSE_IRQ is not set
>> CONFIG_X86_MPPARSE=3Dy
>> CONFIG_X86_EXTENDED_PLATFORM=3Dy
>> # CONFIG_X86_VSMP is not set
>> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
>> CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
>> CONFIG_NO_BOOTMEM=3Dy
>> # CONFIG_MEMTEST is not set
>> # CONFIG_M386 is not set
>> # CONFIG_M486 is not set
>> # CONFIG_M586 is not set
>> # CONFIG_M586TSC is not set
>> # CONFIG_M586MMX is not set
>> # CONFIG_M686 is not set
>> # CONFIG_MPENTIUMII is not set
>> # CONFIG_MPENTIUMIII is not set
>> # CONFIG_MPENTIUMM is not set
>> # CONFIG_MPENTIUM4 is not set
>> # CONFIG_MK6 is not set
>> # CONFIG_MK7 is not set
>> # CONFIG_MK8 is not set
>> # CONFIG_MCRUSOE is not set
>> # CONFIG_MEFFICEON is not set
>> # CONFIG_MWINCHIPC6 is not set
>> # CONFIG_MWINCHIP3D is not set
>> # CONFIG_MGEODEGX1 is not set
>> # CONFIG_MGEODE_LX is not set
>> # CONFIG_MCYRIXIII is not set
>> # CONFIG_MVIAC3_2 is not set
>> # CONFIG_MVIAC7 is not set
>> # CONFIG_MPSC is not set
>> CONFIG_MCORE2=3Dy
>> # CONFIG_MATOM is not set
>> # CONFIG_GENERIC_CPU is not set
>> CONFIG_X86_CPU=3Dy
>> CONFIG_X86_INTERNODE_CACHE_SHIFT=3D7
>> CONFIG_X86_CMPXCHG=3Dy
>> CONFIG_X86_L1_CACHE_SHIFT=3D6
>> CONFIG_X86_XADD=3Dy
>> CONFIG_X86_WP_WORKS_OK=3Dy
>> CONFIG_X86_INTEL_USERCOPY=3Dy
>> CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
>> CONFIG_X86_P6_NOP=3Dy
>> CONFIG_X86_TSC=3Dy
>> CONFIG_X86_CMPXCHG64=3Dy
>> CONFIG_X86_CMOV=3Dy
>> CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
>> CONFIG_X86_DEBUGCTLMSR=3Dy
>> CONFIG_CPU_SUP_INTEL=3Dy
>> CONFIG_CPU_SUP_AMD=3Dy
>> CONFIG_CPU_SUP_CENTAUR=3Dy
>> # CONFIG_X86_DS is not set
>> CONFIG_HPET_TIMER=3Dy
>> CONFIG_HPET_EMULATE_RTC=3Dy
>> CONFIG_DMI=3Dy
>> CONFIG_GART_IOMMU=3Dy
>> CONFIG_CALGARY_IOMMU=3Dy
>> CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=3Dy
>> CONFIG_AMD_IOMMU=3Dy
>> CONFIG_AMD_IOMMU_STATS=3Dy
>> CONFIG_SWIOTLB=3Dy
>> CONFIG_IOMMU_HELPER=3Dy
>> CONFIG_IOMMU_API=3Dy
>> # CONFIG_MAXSMP is not set
>> CONFIG_NR_CPUS=3D8
>> CONFIG_SCHED_SMT=3Dy
>> CONFIG_SCHED_MC=3Dy
>> CONFIG_PREEMPT_NONE=3Dy
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> # CONFIG_PREEMPT is not set
>> CONFIG_IPIPE=3Dy
>> CONFIG_IPIPE_DOMAINS=3D8
>> CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy
>> # CONFIG_IPIPE_UNMASKED_CONTEXT_SWITCH is not set
>> CONFIG_X86_LOCAL_APIC=3Dy
>> CONFIG_X86_IO_APIC=3Dy
>> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
>> CONFIG_X86_MCE=3Dy
>> CONFIG_X86_MCE_INTEL=3Dy
>> CONFIG_X86_MCE_AMD=3Dy
>> CONFIG_X86_MCE_THRESHOLD=3Dy
>> # CONFIG_X86_MCE_INJECT is not set
>> CONFIG_X86_THERMAL_VECTOR=3Dy
>> CONFIG_I8K=3Dm
>> CONFIG_MICROCODE=3Dm
>> CONFIG_MICROCODE_INTEL=3Dy
>> CONFIG_MICROCODE_AMD=3Dy
>> CONFIG_MICROCODE_OLD_INTERFACE=3Dy
>> CONFIG_X86_MSR=3Dy
>> CONFIG_X86_CPUID=3Dy
>> CONFIG_ARCH_PHYS_ADDR_T_64BIT=3Dy
>> CONFIG_DIRECT_GBPAGES=3Dy
>> CONFIG_NUMA=3Dy
>> CONFIG_K8_NUMA=3Dy
>> CONFIG_X86_64_ACPI_NUMA=3Dy
>> CONFIG_NODES_SPAN_OTHER_NODES=3Dy
>> # CONFIG_NUMA_EMU is not set
>> CONFIG_NODES_SHIFT=3D9
>> CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
>> CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
>> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
>> CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
>> CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
>> CONFIG_SELECT_MEMORY_MODEL=3Dy
>> # CONFIG_FLATMEM_MANUAL is not set
>> # CONFIG_DISCONTIGMEM_MANUAL is not set
>> CONFIG_SPARSEMEM_MANUAL=3Dy
>> CONFIG_SPARSEMEM=3Dy
>> CONFIG_NEED_MULTIPLE_NODES=3Dy
>> CONFIG_HAVE_MEMORY_PRESENT=3Dy
>> CONFIG_SPARSEMEM_EXTREME=3Dy
>> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
>> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=3Dy
>> CONFIG_SPARSEMEM_VMEMMAP=3Dy
>> # CONFIG_MEMORY_HOTPLUG is not set
>> CONFIG_PAGEFLAGS_EXTENDED=3Dy
>> CONFIG_SPLIT_PTLOCK_CPUS=3D4
>> CONFIG_MIGRATION=3Dy
>> CONFIG_PHYS_ADDR_T_64BIT=3Dy
>> CONFIG_ZONE_DMA_FLAG=3D1
>> CONFIG_BOUNCE=3Dy
>> CONFIG_VIRT_TO_BUS=3Dy
>> # CONFIG_KSM is not set
>> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
>> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
>> # CONFIG_MEMORY_FAILURE is not set
>> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
>> CONFIG_X86_RESERVE_LOW_64K=3Dy
>> CONFIG_MTRR=3Dy
>> CONFIG_MTRR_SANITIZER=3Dy
>> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D1
>> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
>> CONFIG_X86_PAT=3Dy
>> CONFIG_ARCH_USES_PG_UNCACHED=3Dy
>> CONFIG_EFI=3Dy
>> CONFIG_SECCOMP=3Dy
>> # CONFIG_CC_STACKPROTECTOR is not set
>> CONFIG_HZ_100=3Dy
>> # CONFIG_HZ_250 is not set
>> # CONFIG_HZ_300 is not set
>> # CONFIG_HZ_1000 is not set
>> CONFIG_HZ=3D100
>> # CONFIG_SCHED_HRTICK is not set
>> CONFIG_KEXEC=3Dy
>> CONFIG_CRASH_DUMP=3Dy
>> CONFIG_PHYSICAL_START=3D0x1000000
>> CONFIG_RELOCATABLE=3Dy
>> CONFIG_PHYSICAL_ALIGN=3D0x1000000
>> CONFIG_HOTPLUG_CPU=3Dy
>> # CONFIG_COMPAT_VDSO is not set
>> # CONFIG_CMDLINE_BOOL is not set
>> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
>> CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=3Dy
>>
>> #
>> # Power management and ACPI options
>> #
>> CONFIG_PM=3Dy
>> # CONFIG_PM_DEBUG is not set
>> # CONFIG_SUSPEND is not set
>> # CONFIG_HIBERNATION is not set
>> # CONFIG_PM_RUNTIME is not set
>> CONFIG_ACPI=3Dy
>> CONFIG_ACPI_PROCFS=3Dy
>> CONFIG_ACPI_PROCFS_POWER=3Dy
>> # CONFIG_ACPI_POWER_METER is not set
>> CONFIG_ACPI_SYSFS_POWER=3Dy
>> CONFIG_ACPI_PROC_EVENT=3Dy
>> CONFIG_ACPI_AC=3Dy
>> CONFIG_ACPI_BATTERY=3Dy
>> CONFIG_ACPI_BUTTON=3Dy
>> CONFIG_ACPI_VIDEO=3Dm
>> CONFIG_ACPI_FAN=3Dy
>> CONFIG_ACPI_DOCK=3Dy
>> # CONFIG_ACPI_PROCESSOR is not set
>> CONFIG_ACPI_NUMA=3Dy
>> # CONFIG_ACPI_CUSTOM_DSDT is not set
>> CONFIG_ACPI_BLACKLIST_YEAR=3D0
>> # CONFIG_ACPI_DEBUG is not set
>> CONFIG_ACPI_PCI_SLOT=3Dy
>> CONFIG_X86_PM_TIMER=3Dy
>> CONFIG_ACPI_CONTAINER=3Dy
>> CONFIG_ACPI_SBS=3Dm
>> # CONFIG_SFI is not set
>>
>> #
>> # CPU Frequency scaling
>> #
>> # CONFIG_CPU_FREQ is not set
>> CONFIG_CPU_IDLE=3Dy
>> CONFIG_CPU_IDLE_GOV_LADDER=3Dy
>> CONFIG_CPU_IDLE_GOV_MENU=3Dy
>>
>> #
>> # Memory power savings
>> #
>> CONFIG_I7300_IDLE_IOAT_CHANNEL=3Dy
>> CONFIG_I7300_IDLE=3Dm
>>
>> #
>> # Bus options (PCI etc.)
>> #
>> CONFIG_PCI=3Dy
>> CONFIG_PCI_DIRECT=3Dy
>> CONFIG_PCI_MMCONFIG=3Dy
>> CONFIG_PCI_DOMAINS=3Dy
>> CONFIG_DMAR=3Dy
>> # CONFIG_DMAR_DEFAULT_ON is not set
>> CONFIG_DMAR_FLOPPY_WA=3Dy
>> CONFIG_INTR_REMAP=3Dy
>> CONFIG_PCIEPORTBUS=3Dy
>> CONFIG_HOTPLUG_PCI_PCIE=3Dy
>> CONFIG_PCIEAER=3Dy
>> # CONFIG_PCIE_ECRC is not set
>> # CONFIG_PCIEAER_INJECT is not set
>> CONFIG_PCIEASPM=3Dy
>> # CONFIG_PCIEASPM_DEBUG is not set
>> CONFIG_ARCH_SUPPORTS_MSI=3Dy
>> CONFIG_PCI_MSI=3Dy
>> # CONFIG_PCI_DEBUG is not set
>> CONFIG_PCI_STUB=3Dy
>> CONFIG_HT_IRQ=3Dy
>> # CONFIG_PCI_IOV is not set
>> CONFIG_PCI_IOAPIC=3Dy
>> CONFIG_ISA_DMA_API=3Dy
>> CONFIG_K8_NB=3Dy
>> CONFIG_PCCARD=3Dy
>> CONFIG_PCMCIA=3Dy
>> CONFIG_PCMCIA_LOAD_CIS=3Dy
>> CONFIG_CARDBUS=3Dy
>>
>> #
>> # PC-card bridges
>> #
>> CONFIG_YENTA=3Dm
>> CONFIG_YENTA_O2=3Dy
>> CONFIG_YENTA_RICOH=3Dy
>> CONFIG_YENTA_TI=3Dy
>> CONFIG_YENTA_ENE_TUNE=3Dy
>> CONFIG_YENTA_TOSHIBA=3Dy
>> CONFIG_PD6729=3Dm
>> CONFIG_I82092=3Dm
>> CONFIG_PCCARD_NONSTATIC=3Dm
>> CONFIG_HOTPLUG_PCI=3Dy
>> CONFIG_HOTPLUG_PCI_FAKE=3Dm
>> CONFIG_HOTPLUG_PCI_ACPI=3Dy
>> CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
>> # CONFIG_HOTPLUG_PCI_CPCI is not set
>> CONFIG_HOTPLUG_PCI_SHPC=3Dm
>>
>> #
>> # Executable file formats / Emulations
>> #
>> CONFIG_BINFMT_ELF=3Dy
>> CONFIG_COMPAT_BINFMT_ELF=3Dy
>> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
>> # CONFIG_HAVE_AOUT is not set
>> CONFIG_BINFMT_MISC=3Dy
>> CONFIG_IA32_EMULATION=3Dy
>> # CONFIG_IA32_AOUT is not set
>> CONFIG_COMPAT=3Dy
>> CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
>> CONFIG_SYSVIPC_COMPAT=3Dy
>> CONFIG_NET=3Dy
>> CONFIG_COMPAT_NETLINK_MESSAGES=3Dy
>>
>> #
>> # Networking options
>> #
>> CONFIG_PACKET=3Dy
>> CONFIG_UNIX=3Dy
>> CONFIG_XFRM=3Dy
>> CONFIG_XFRM_USER=3Dy
>> CONFIG_XFRM_SUB_POLICY=3Dy
>> CONFIG_XFRM_MIGRATE=3Dy
>> CONFIG_XFRM_STATISTICS=3Dy
>> CONFIG_XFRM_IPCOMP=3Dm
>> CONFIG_NET_KEY=3Dm
>> CONFIG_NET_KEY_MIGRATE=3Dy
>> CONFIG_INET=3Dy
>> CONFIG_IP_MULTICAST=3Dy
>> CONFIG_IP_ADVANCED_ROUTER=3Dy
>> CONFIG_ASK_IP_FIB_HASH=3Dy
>> # CONFIG_IP_FIB_TRIE is not set
>> CONFIG_IP_FIB_HASH=3Dy
>> CONFIG_IP_MULTIPLE_TABLES=3Dy
>> CONFIG_IP_ROUTE_MULTIPATH=3Dy
>> CONFIG_IP_ROUTE_VERBOSE=3Dy
>> # CONFIG_IP_PNP is not set
>> CONFIG_NET_IPIP=3Dm
>> CONFIG_NET_IPGRE=3Dm
>> CONFIG_NET_IPGRE_BROADCAST=3Dy
>> CONFIG_IP_MROUTE=3Dy
>> CONFIG_IP_PIMSM_V1=3Dy
>> CONFIG_IP_PIMSM_V2=3Dy
>> # CONFIG_ARPD is not set
>> CONFIG_SYN_COOKIES=3Dy
>> CONFIG_INET_AH=3Dm
>> CONFIG_INET_ESP=3Dm
>> CONFIG_INET_IPCOMP=3Dm
>> CONFIG_INET_XFRM_TUNNEL=3Dm
>> CONFIG_INET_TUNNEL=3Dm
>> CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm
>> CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
>> CONFIG_INET_XFRM_MODE_BEET=3Dm
>> CONFIG_INET_LRO=3Dy
>> CONFIG_INET_DIAG=3Dm
>> CONFIG_INET_TCP_DIAG=3Dm
>> CONFIG_TCP_CONG_ADVANCED=3Dy
>> CONFIG_TCP_CONG_BIC=3Dm
>> CONFIG_TCP_CONG_CUBIC=3Dy
>> CONFIG_TCP_CONG_WESTWOOD=3Dm
>> CONFIG_TCP_CONG_HTCP=3Dm
>> CONFIG_TCP_CONG_HSTCP=3Dm
>> CONFIG_TCP_CONG_HYBLA=3Dm
>> CONFIG_TCP_CONG_VEGAS=3Dm
>> CONFIG_TCP_CONG_SCALABLE=3Dm
>> CONFIG_TCP_CONG_LP=3Dm
>> CONFIG_TCP_CONG_VENO=3Dm
>> CONFIG_TCP_CONG_YEAH=3Dm
>> CONFIG_TCP_CONG_ILLINOIS=3Dm
>> # CONFIG_DEFAULT_BIC is not set
>> CONFIG_DEFAULT_CUBIC=3Dy
>> # CONFIG_DEFAULT_HTCP is not set
>> # CONFIG_DEFAULT_VEGAS is not set
>> # CONFIG_DEFAULT_WESTWOOD is not set
>> # CONFIG_DEFAULT_RENO is not set
>> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
>> CONFIG_TCP_MD5SIG=3Dy
>> # CONFIG_IPV6 is not set
>> CONFIG_NETLABEL=3Dy
>> CONFIG_NETWORK_SECMARK=3Dy
>> CONFIG_NETFILTER=3Dy
>> # CONFIG_NETFILTER_DEBUG is not set
>> CONFIG_NETFILTER_ADVANCED=3Dy
>> CONFIG_BRIDGE_NETFILTER=3Dy
>>
>> #
>> # Core Netfilter Configuration
>> #
>> CONFIG_NETFILTER_NETLINK=3Dm
>> CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
>> CONFIG_NETFILTER_NETLINK_LOG=3Dm
>> CONFIG_NF_CONNTRACK=3Dy
>> CONFIG_NF_CT_ACCT=3Dy
>> CONFIG_NF_CONNTRACK_MARK=3Dy
>> CONFIG_NF_CONNTRACK_SECMARK=3Dy
>> CONFIG_NF_CONNTRACK_EVENTS=3Dy
>> CONFIG_NF_CT_PROTO_DCCP=3Dm
>> CONFIG_NF_CT_PROTO_GRE=3Dm
>> CONFIG_NF_CT_PROTO_SCTP=3Dm
>> CONFIG_NF_CT_PROTO_UDPLITE=3Dm
>> CONFIG_NF_CONNTRACK_AMANDA=3Dm
>> CONFIG_NF_CONNTRACK_FTP=3Dm
>> CONFIG_NF_CONNTRACK_H323=3Dm
>> CONFIG_NF_CONNTRACK_IRC=3Dm
>> CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
>> CONFIG_NF_CONNTRACK_PPTP=3Dm
>> CONFIG_NF_CONNTRACK_SANE=3Dm
>> CONFIG_NF_CONNTRACK_SIP=3Dm
>> CONFIG_NF_CONNTRACK_TFTP=3Dm
>> CONFIG_NF_CT_NETLINK=3Dm
>> CONFIG_NETFILTER_TPROXY=3Dm
>> CONFIG_NETFILTER_XTABLES=3Dy
>> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
>> CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
>> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
>> # CONFIG_NETFILTER_XT_TARGET_CT is not set
>> CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
>> CONFIG_NETFILTER_XT_TARGET_HL=3Dm
>> # CONFIG_NETFILTER_XT_TARGET_LED is not set
>> CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
>> CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
>> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
>> CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
>> CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
>> CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
>> CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
>> CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
>> CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
>> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm
>> # CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
>> CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
>> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
>> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
>> CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
>> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy
>> CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
>> CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
>> CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
>> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
>> CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
>> CONFIG_NETFILTER_XT_MATCH_HL=3Dm
>> CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
>> CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
>> CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
>> CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
>> CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
>> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
>> CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
>> CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
>> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
>> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
>> CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
>> CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
>> CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
>> CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
>> # CONFIG_NETFILTER_XT_MATCH_RECENT_PROC_COMPAT is not set
>> CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
>> CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
>> CONFIG_NETFILTER_XT_MATCH_STATE=3Dy
>> CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
>> CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
>> CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
>> CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
>> CONFIG_NETFILTER_XT_MATCH_U32=3Dm
>> # CONFIG_NETFILTER_XT_MATCH_OSF is not set
>> CONFIG_IP_VS=3Dm
>> # CONFIG_IP_VS_DEBUG is not set
>> CONFIG_IP_VS_TAB_BITS=3D12
>>
>> #
>> # IPVS transport protocol load balancing support
>> #
>> CONFIG_IP_VS_PROTO_TCP=3Dy
>> CONFIG_IP_VS_PROTO_UDP=3Dy
>> CONFIG_IP_VS_PROTO_AH_ESP=3Dy
>> CONFIG_IP_VS_PROTO_ESP=3Dy
>> CONFIG_IP_VS_PROTO_AH=3Dy
>> # CONFIG_IP_VS_PROTO_SCTP is not set
>>
>> #
>> # IPVS scheduler
>> #
>> CONFIG_IP_VS_RR=3Dm
>> CONFIG_IP_VS_WRR=3Dm
>> CONFIG_IP_VS_LC=3Dm
>> CONFIG_IP_VS_WLC=3Dm
>> CONFIG_IP_VS_LBLC=3Dm
>> CONFIG_IP_VS_LBLCR=3Dm
>> CONFIG_IP_VS_DH=3Dm
>> CONFIG_IP_VS_SH=3Dm
>> CONFIG_IP_VS_SED=3Dm
>> CONFIG_IP_VS_NQ=3Dm
>>
>> #
>> # IPVS application helper
>> #
>> CONFIG_IP_VS_FTP=3Dm
>>
>> #
>> # IP: Netfilter Configuration
>> #
>> CONFIG_NF_DEFRAG_IPV4=3Dy
>> CONFIG_NF_CONNTRACK_IPV4=3Dy
>> # CONFIG_NF_CONNTRACK_PROC_COMPAT is not set
>> CONFIG_IP_NF_QUEUE=3Dm
>> CONFIG_IP_NF_IPTABLES=3Dy
>> CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm
>> CONFIG_IP_NF_MATCH_AH=3Dm
>> CONFIG_IP_NF_MATCH_ECN=3Dm
>> CONFIG_IP_NF_MATCH_TTL=3Dm
>> CONFIG_IP_NF_FILTER=3Dy
>> CONFIG_IP_NF_TARGET_REJECT=3Dy
>> CONFIG_IP_NF_TARGET_LOG=3Dm
>> CONFIG_IP_NF_TARGET_ULOG=3Dm
>> CONFIG_NF_NAT=3Dm
>> CONFIG_NF_NAT_NEEDED=3Dy
>> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
>> CONFIG_IP_NF_TARGET_NETMAP=3Dm
>> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
>> CONFIG_NF_NAT_SNMP_BASIC=3Dm
>> CONFIG_NF_NAT_PROTO_DCCP=3Dm
>> CONFIG_NF_NAT_PROTO_GRE=3Dm
>> CONFIG_NF_NAT_PROTO_UDPLITE=3Dm
>> CONFIG_NF_NAT_PROTO_SCTP=3Dm
>> CONFIG_NF_NAT_FTP=3Dm
>> CONFIG_NF_NAT_IRC=3Dm
>> CONFIG_NF_NAT_TFTP=3Dm
>> CONFIG_NF_NAT_AMANDA=3Dm
>> CONFIG_NF_NAT_PPTP=3Dm
>> CONFIG_NF_NAT_H323=3Dm
>> CONFIG_NF_NAT_SIP=3Dm
>> CONFIG_IP_NF_MANGLE=3Dm
>> CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
>> CONFIG_IP_NF_TARGET_ECN=3Dm
>> CONFIG_IP_NF_TARGET_TTL=3Dm
>> CONFIG_IP_NF_RAW=3Dm
>> CONFIG_IP_NF_SECURITY=3Dm
>> CONFIG_IP_NF_ARPTABLES=3Dm
>> CONFIG_IP_NF_ARPFILTER=3Dm
>> CONFIG_IP_NF_ARP_MANGLE=3Dm
>>
>> #
>> # DECnet: Netfilter Configuration
>> #
>> # CONFIG_DECNET_NF_GRABULATOR is not set
>> CONFIG_BRIDGE_NF_EBTABLES=3Dm
>> CONFIG_BRIDGE_EBT_BROUTE=3Dm
>> CONFIG_BRIDGE_EBT_T_FILTER=3Dm
>> CONFIG_BRIDGE_EBT_T_NAT=3Dm
>> CONFIG_BRIDGE_EBT_802_3=3Dm
>> CONFIG_BRIDGE_EBT_AMONG=3Dm
>> CONFIG_BRIDGE_EBT_ARP=3Dm
>> CONFIG_BRIDGE_EBT_IP=3Dm
>> CONFIG_BRIDGE_EBT_LIMIT=3Dm
>> CONFIG_BRIDGE_EBT_MARK=3Dm
>> CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
>> CONFIG_BRIDGE_EBT_STP=3Dm
>> CONFIG_BRIDGE_EBT_VLAN=3Dm
>> CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
>> CONFIG_BRIDGE_EBT_DNAT=3Dm
>> CONFIG_BRIDGE_EBT_MARK_T=3Dm
>> CONFIG_BRIDGE_EBT_REDIRECT=3Dm
>> CONFIG_BRIDGE_EBT_SNAT=3Dm
>> CONFIG_BRIDGE_EBT_LOG=3Dm
>> CONFIG_BRIDGE_EBT_ULOG=3Dm
>> CONFIG_BRIDGE_EBT_NFLOG=3Dm
>> CONFIG_IP_DCCP=3Dm
>> CONFIG_INET_DCCP_DIAG=3Dm
>>
>> #
>> # DCCP CCIDs Configuration (EXPERIMENTAL)
>> #
>> # CONFIG_IP_DCCP_CCID2_DEBUG is not set
>> CONFIG_IP_DCCP_CCID3=3Dy
>> # CONFIG_IP_DCCP_CCID3_DEBUG is not set
>> CONFIG_IP_DCCP_CCID3_RTO=3D100
>> CONFIG_IP_DCCP_TFRC_LIB=3Dy
>>
>> #
>> # DCCP Kernel Hacking
>> #
>> # CONFIG_IP_DCCP_DEBUG is not set
>> CONFIG_NET_DCCPPROBE=3Dm
>> CONFIG_IP_SCTP=3Dm
>> # CONFIG_SCTP_DBG_MSG is not set
>> # CONFIG_SCTP_DBG_OBJCNT is not set
>> # CONFIG_SCTP_HMAC_NONE is not set
>> CONFIG_SCTP_HMAC_SHA1=3Dy
>> # CONFIG_SCTP_HMAC_MD5 is not set
>> # CONFIG_RDS is not set
>> CONFIG_TIPC=3Dm
>> # CONFIG_TIPC_ADVANCED is not set
>> # CONFIG_TIPC_DEBUG is not set
>> CONFIG_ATM=3Dm
>> CONFIG_ATM_CLIP=3Dm
>> # CONFIG_ATM_CLIP_NO_ICMP is not set
>> CONFIG_ATM_LANE=3Dm
>> # CONFIG_ATM_MPOA is not set
>> CONFIG_ATM_BR2684=3Dm
>> # CONFIG_ATM_BR2684_IPFILTER is not set
>> CONFIG_STP=3Dm
>> CONFIG_GARP=3Dm
>> CONFIG_BRIDGE=3Dm
>> CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
>> CONFIG_NET_DSA=3Dy
>> CONFIG_NET_DSA_TAG_DSA=3Dy
>> CONFIG_NET_DSA_TAG_EDSA=3Dy
>> CONFIG_NET_DSA_TAG_TRAILER=3Dy
>> CONFIG_NET_DSA_MV88E6XXX=3Dy
>> CONFIG_NET_DSA_MV88E6060=3Dy
>> CONFIG_NET_DSA_MV88E6XXX_NEED_PPU=3Dy
>> CONFIG_NET_DSA_MV88E6131=3Dy
>> CONFIG_NET_DSA_MV88E6123_61_65=3Dy
>> CONFIG_VLAN_8021Q=3Dm
>> CONFIG_VLAN_8021Q_GVRP=3Dy
>> CONFIG_DECNET=3Dm
>> CONFIG_DECNET_ROUTER=3Dy
>> CONFIG_LLC=3Dm
>> # CONFIG_LLC2 is not set
>> CONFIG_IPX=3Dm
>> # CONFIG_IPX_INTERN is not set
>> CONFIG_ATALK=3Dm
>> CONFIG_DEV_APPLETALK=3Dm
>> CONFIG_IPDDP=3Dm
>> CONFIG_IPDDP_ENCAP=3Dy
>> CONFIG_IPDDP_DECAP=3Dy
>> # CONFIG_X25 is not set
>> # CONFIG_LAPB is not set
>> # CONFIG_ECONET is not set
>> CONFIG_WAN_ROUTER=3Dm
>> CONFIG_PHONET=3Dm
>> # CONFIG_IEEE802154 is not set
>> CONFIG_NET_SCHED=3Dy
>>
>> #
>> # Queueing/Scheduling
>> #
>> CONFIG_NET_SCH_CBQ=3Dm
>> CONFIG_NET_SCH_HTB=3Dm
>> CONFIG_NET_SCH_HFSC=3Dm
>> CONFIG_NET_SCH_ATM=3Dm
>> CONFIG_NET_SCH_PRIO=3Dm
>> CONFIG_NET_SCH_MULTIQ=3Dm
>> CONFIG_NET_SCH_RED=3Dm
>> CONFIG_NET_SCH_SFQ=3Dm
>> CONFIG_NET_SCH_TEQL=3Dm
>> CONFIG_NET_SCH_TBF=3Dm
>> CONFIG_NET_SCH_GRED=3Dm
>> CONFIG_NET_SCH_DSMARK=3Dm
>> CONFIG_NET_SCH_NETEM=3Dm
>> CONFIG_NET_SCH_DRR=3Dm
>> CONFIG_NET_SCH_INGRESS=3Dm
>>
>> #
>> # Classification
>> #
>> CONFIG_NET_CLS=3Dy
>> CONFIG_NET_CLS_BASIC=3Dm
>> CONFIG_NET_CLS_TCINDEX=3Dm
>> CONFIG_NET_CLS_ROUTE4=3Dm
>> CONFIG_NET_CLS_ROUTE=3Dy
>> CONFIG_NET_CLS_FW=3Dm
>> CONFIG_NET_CLS_U32=3Dm
>> CONFIG_CLS_U32_PERF=3Dy
>> CONFIG_CLS_U32_MARK=3Dy
>> CONFIG_NET_CLS_RSVP=3Dm
>> CONFIG_NET_CLS_RSVP6=3Dm
>> CONFIG_NET_CLS_FLOW=3Dm
>> CONFIG_NET_CLS_CGROUP=3Dy
>> CONFIG_NET_EMATCH=3Dy
>> CONFIG_NET_EMATCH_STACK=3D32
>> CONFIG_NET_EMATCH_CMP=3Dm
>> CONFIG_NET_EMATCH_NBYTE=3Dm
>> CONFIG_NET_EMATCH_U32=3Dm
>> CONFIG_NET_EMATCH_META=3Dm
>> CONFIG_NET_EMATCH_TEXT=3Dm
>> CONFIG_NET_CLS_ACT=3Dy
>> CONFIG_NET_ACT_POLICE=3Dm
>> CONFIG_NET_ACT_GACT=3Dm
>> CONFIG_GACT_PROB=3Dy
>> CONFIG_NET_ACT_MIRRED=3Dm
>> CONFIG_NET_ACT_IPT=3Dm
>> CONFIG_NET_ACT_NAT=3Dm
>> CONFIG_NET_ACT_PEDIT=3Dm
>> CONFIG_NET_ACT_SIMP=3Dm
>> CONFIG_NET_ACT_SKBEDIT=3Dm
>> CONFIG_NET_CLS_IND=3Dy
>> CONFIG_NET_SCH_FIFO=3Dy
>> CONFIG_DCB=3Dy
>>
>> #
>> # Network testing
>> #
>> CONFIG_NET_PKTGEN=3Dm
>> # CONFIG_NET_TCPPROBE is not set
>> CONFIG_NET_DROP_MONITOR=3Dy
>> CONFIG_HAMRADIO=3Dy
>>
>> #
>> # Packet Radio protocols
>> #
>> CONFIG_AX25=3Dm
>> CONFIG_AX25_DAMA_SLAVE=3Dy
>> CONFIG_NETROM=3Dm
>> CONFIG_ROSE=3Dm
>>
>> #
>> # AX.25 network device drivers
>> #
>> CONFIG_MKISS=3Dm
>> CONFIG_6PACK=3Dm
>> CONFIG_BPQETHER=3Dm
>> CONFIG_BAYCOM_SER_FDX=3Dm
>> CONFIG_BAYCOM_SER_HDX=3Dm
>> CONFIG_BAYCOM_PAR=3Dm
>> CONFIG_YAM=3Dm
>> CONFIG_CAN=3Dm
>> CONFIG_CAN_RAW=3Dm
>> CONFIG_CAN_BCM=3Dm
>>
>> #
>> # CAN Device Drivers
>> #
>> CONFIG_CAN_VCAN=3Dm
>> # CONFIG_CAN_DEV is not set
>> # CONFIG_CAN_DEBUG_DEVICES is not set
>> CONFIG_IRDA=3Dm
>>
>> #
>> # IrDA protocols
>> #
>> CONFIG_IRLAN=3Dm
>> CONFIG_IRNET=3Dm
>> CONFIG_IRCOMM=3Dm
>> # CONFIG_IRDA_ULTRA is not set
>>
>> #
>> # IrDA options
>> #
>> CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
>> CONFIG_IRDA_FAST_RR=3Dy
>> # CONFIG_IRDA_DEBUG is not set
>>
>> #
>> # Infrared-port device drivers
>> #
>>
>> #
>> # SIR device drivers
>> #
>> CONFIG_IRTTY_SIR=3Dm
>>
>> #
>> # Dongle support
>> #
>> CONFIG_DONGLE=3Dy
>> CONFIG_ESI_DONGLE=3Dm
>> CONFIG_ACTISYS_DONGLE=3Dm
>> CONFIG_TEKRAM_DONGLE=3Dm
>> CONFIG_TOIM3232_DONGLE=3Dm
>> CONFIG_LITELINK_DONGLE=3Dm
>> CONFIG_MA600_DONGLE=3Dm
>> CONFIG_GIRBIL_DONGLE=3Dm
>> CONFIG_MCP2120_DONGLE=3Dm
>> CONFIG_OLD_BELKIN_DONGLE=3Dm
>> CONFIG_ACT200L_DONGLE=3Dm
>> CONFIG_KINGSUN_DONGLE=3Dm
>> CONFIG_KSDAZZLE_DONGLE=3Dm
>> CONFIG_KS959_DONGLE=3Dm
>>
>> #
>> # FIR device drivers
>> #
>> CONFIG_USB_IRDA=3Dm
>> CONFIG_SIGMATEL_FIR=3Dm
>> CONFIG_NSC_FIR=3Dm
>> CONFIG_WINBOND_FIR=3Dm
>> CONFIG_SMC_IRCC_FIR=3Dm
>> CONFIG_ALI_FIR=3Dm
>> CONFIG_VLSI_FIR=3Dm
>> CONFIG_VIA_FIR=3Dm
>> CONFIG_MCS_FIR=3Dm
>> CONFIG_BT=3Dm
>> CONFIG_BT_L2CAP=3Dm
>> CONFIG_BT_SCO=3Dm
>> CONFIG_BT_RFCOMM=3Dm
>> CONFIG_BT_RFCOMM_TTY=3Dy
>> CONFIG_BT_BNEP=3Dm
>> CONFIG_BT_BNEP_MC_FILTER=3Dy
>> CONFIG_BT_BNEP_PROTO_FILTER=3Dy
>> CONFIG_BT_CMTP=3Dm
>> CONFIG_BT_HIDP=3Dm
>>
>> #
>> # Bluetooth device drivers
>> #
>> CONFIG_BT_HCIBTUSB=3Dm
>> CONFIG_BT_HCIBTSDIO=3Dm
>> CONFIG_BT_HCIUART=3Dm
>> CONFIG_BT_HCIUART_H4=3Dy
>> CONFIG_BT_HCIUART_BCSP=3Dy
>> CONFIG_BT_HCIUART_LL=3Dy
>> CONFIG_BT_HCIBCM203X=3Dm
>> CONFIG_BT_HCIBPA10X=3Dm
>> CONFIG_BT_HCIBFUSB=3Dm
>> CONFIG_BT_HCIDTL1=3Dm
>> CONFIG_BT_HCIBT3C=3Dm
>> CONFIG_BT_HCIBLUECARD=3Dm
>> CONFIG_BT_HCIBTUART=3Dm
>> CONFIG_BT_HCIVHCI=3Dm
>> # CONFIG_BT_MRVL is not set
>> # CONFIG_BT_ATH3K is not set
>> # CONFIG_AF_RXRPC is not set
>> CONFIG_FIB_RULES=3Dy
>> CONFIG_WIRELESS=3Dy
>> CONFIG_WIRELESS_EXT=3Dy
>> CONFIG_WEXT_CORE=3Dy
>> CONFIG_WEXT_PROC=3Dy
>> CONFIG_WEXT_SPY=3Dy
>> CONFIG_WEXT_PRIV=3Dy
>> CONFIG_CFG80211=3Dm
>> # CONFIG_NL80211_TESTMODE is not set
>> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
>> # CONFIG_CFG80211_REG_DEBUG is not set
>> CONFIG_CFG80211_DEFAULT_PS=3Dy
>> # CONFIG_CFG80211_DEBUGFS is not set
>> # CONFIG_CFG80211_INTERNAL_REGDB is not set
>> CONFIG_CFG80211_WEXT=3Dy
>> CONFIG_WIRELESS_EXT_SYSFS=3Dy
>> CONFIG_LIB80211=3Dm
>> CONFIG_LIB80211_CRYPT_WEP=3Dm
>> CONFIG_LIB80211_CRYPT_CCMP=3Dm
>> CONFIG_LIB80211_CRYPT_TKIP=3Dm
>> # CONFIG_LIB80211_DEBUG is not set
>> CONFIG_MAC80211=3Dm
>> CONFIG_MAC80211_HAS_RC=3Dy
>> CONFIG_MAC80211_RC_MINSTREL=3Dy
>> # CONFIG_MAC80211_RC_DEFAULT_PID is not set
>> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
>> CONFIG_MAC80211_RC_DEFAULT=3D"minstrel"
>> CONFIG_MAC80211_MESH=3Dy
>> CONFIG_MAC80211_LEDS=3Dy
>> CONFIG_MAC80211_DEBUGFS=3Dy
>> # CONFIG_MAC80211_DEBUG_MENU is not set
>> CONFIG_WIMAX=3Dy
>> CONFIG_WIMAX_DEBUG_LEVEL=3D8
>> CONFIG_RFKILL=3Dy
>> CONFIG_RFKILL_LEDS=3Dy
>> CONFIG_RFKILL_INPUT=3Dy
>> CONFIG_NET_9P=3Dm
>> CONFIG_NET_9P_RDMA=3Dm
>> # CONFIG_NET_9P_DEBUG is not set
>>
>> #
>> # Device Drivers
>> #
>>
>> #
>> # Generic Driver Options
>> #
>> CONFIG_UEVENT_HELPER_PATH=3D""
>> # CONFIG_DEVTMPFS is not set
>> CONFIG_STANDALONE=3Dy
>> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
>> CONFIG_FW_LOADER=3Dy
>> # CONFIG_FIRMWARE_IN_KERNEL is not set
>> CONFIG_EXTRA_FIRMWARE=3D""
>> # CONFIG_DEBUG_DRIVER is not set
>> CONFIG_DEBUG_DEVRES=3Dy
>> # CONFIG_SYS_HYPERVISOR is not set
>> CONFIG_CONNECTOR=3Dy
>> CONFIG_PROC_EVENTS=3Dy
>> CONFIG_MTD=3Dm
>> # CONFIG_MTD_DEBUG is not set
>> # CONFIG_MTD_TESTS is not set
>> CONFIG_MTD_CONCAT=3Dm
>> CONFIG_MTD_PARTITIONS=3Dy
>> CONFIG_MTD_REDBOOT_PARTS=3Dm
>> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=3D-1
>> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
>> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
>> CONFIG_MTD_AR7_PARTS=3Dm
>>
>> #
>> # User Modules And Translation Layers
>> #
>> CONFIG_MTD_CHAR=3Dm
>> CONFIG_MTD_BLKDEVS=3Dm
>> CONFIG_MTD_BLOCK=3Dm
>> CONFIG_MTD_BLOCK_RO=3Dm
>> CONFIG_FTL=3Dm
>> CONFIG_NFTL=3Dm
>> CONFIG_NFTL_RW=3Dy
>> CONFIG_INFTL=3Dm
>> CONFIG_RFD_FTL=3Dm
>> CONFIG_SSFDC=3Dm
>> CONFIG_MTD_OOPS=3Dm
>>
>> #
>> # RAM/ROM/Flash chip drivers
>> #
>> CONFIG_MTD_CFI=3Dm
>> CONFIG_MTD_JEDECPROBE=3Dm
>> CONFIG_MTD_GEN_PROBE=3Dm
>> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
>> CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
>> CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
>> CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
>> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
>> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
>> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
>> CONFIG_MTD_CFI_I1=3Dy
>> CONFIG_MTD_CFI_I2=3Dy
>> # CONFIG_MTD_CFI_I4 is not set
>> # CONFIG_MTD_CFI_I8 is not set
>> CONFIG_MTD_CFI_INTELEXT=3Dm
>> CONFIG_MTD_CFI_AMDSTD=3Dm
>> CONFIG_MTD_CFI_STAA=3Dm
>> CONFIG_MTD_CFI_UTIL=3Dm
>> CONFIG_MTD_RAM=3Dm
>> CONFIG_MTD_ROM=3Dm
>> CONFIG_MTD_ABSENT=3Dm
>>
>> #
>> # Mapping drivers for chip access
>> #
>> CONFIG_MTD_COMPLEX_MAPPINGS=3Dy
>> # CONFIG_MTD_PHYSMAP is not set
>> CONFIG_MTD_SC520CDP=3Dm
>> CONFIG_MTD_NETSC520=3Dm
>> CONFIG_MTD_TS5500=3Dm
>> # CONFIG_MTD_SBC_GXX is not set
>> # CONFIG_MTD_AMD76XROM is not set
>> # CONFIG_MTD_ICHXROM is not set
>> CONFIG_MTD_ESB2ROM=3Dm
>> CONFIG_MTD_CK804XROM=3Dm
>> CONFIG_MTD_SCB2_FLASH=3Dm
>> # CONFIG_MTD_NETtel is not set
>> # CONFIG_MTD_L440GX is not set
>> CONFIG_MTD_PCI=3Dm
>> # CONFIG_MTD_INTEL_VR_NOR is not set
>> # CONFIG_MTD_PLATRAM is not set
>>
>> #
>> # Self-contained MTD device drivers
>> #
>> CONFIG_MTD_PMC551=3Dm
>> # CONFIG_MTD_PMC551_BUGFIX is not set
>> # CONFIG_MTD_PMC551_DEBUG is not set
>> # CONFIG_MTD_SLRAM is not set
>> # CONFIG_MTD_PHRAM is not set
>> CONFIG_MTD_MTDRAM=3Dm
>> CONFIG_MTDRAM_TOTAL_SIZE=3D4096
>> CONFIG_MTDRAM_ERASE_SIZE=3D128
>> CONFIG_MTD_BLOCK2MTD=3Dm
>>
>> #
>> # Disk-On-Chip Device Drivers
>> #
>> # CONFIG_MTD_DOC2000 is not set
>> # CONFIG_MTD_DOC2001 is not set
>> # CONFIG_MTD_DOC2001PLUS is not set
>> CONFIG_MTD_NAND=3Dm
>> # CONFIG_MTD_NAND_VERIFY_WRITE is not set
>> CONFIG_MTD_NAND_ECC_SMC=3Dy
>> # CONFIG_MTD_NAND_MUSEUM_IDS is not set
>> CONFIG_MTD_NAND_IDS=3Dm
>> CONFIG_MTD_NAND_DISKONCHIP=3Dm
>> # CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
>> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=3D0
>> # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
>> # CONFIG_MTD_NAND_CAFE is not set
>> CONFIG_MTD_NAND_NANDSIM=3Dm
>> # CONFIG_MTD_NAND_PLATFORM is not set
>> CONFIG_MTD_ALAUDA=3Dm
>> # CONFIG_MTD_ONENAND is not set
>>
>> #
>> # LPDDR flash memory drivers
>> #
>> CONFIG_MTD_LPDDR=3Dm
>> CONFIG_MTD_QINFO_PROBE=3Dm
>>
>> #
>> # UBI - Unsorted block images
>> #
>> CONFIG_MTD_UBI=3Dm
>> CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
>> CONFIG_MTD_UBI_BEB_RESERVE=3D1
>> # CONFIG_MTD_UBI_GLUEBI is not set
>>
>> #
>> # UBI debugging options
>> #
>> # CONFIG_MTD_UBI_DEBUG is not set
>> CONFIG_PARPORT=3Dm
>> CONFIG_PARPORT_PC=3Dm
>> CONFIG_PARPORT_SERIAL=3Dm
>> # CONFIG_PARPORT_PC_FIFO is not set
>> # CONFIG_PARPORT_PC_SUPERIO is not set
>> CONFIG_PARPORT_PC_PCMCIA=3Dm
>> # CONFIG_PARPORT_GSC is not set
>> # CONFIG_PARPORT_AX88796 is not set
>> CONFIG_PARPORT_1284=3Dy
>> CONFIG_PARPORT_NOT_PC=3Dy
>> CONFIG_PNP=3Dy
>> # CONFIG_PNP_DEBUG_MESSAGES is not set
>>
>> #
>> # Protocols
>> #
>> CONFIG_PNPACPI=3Dy
>> CONFIG_BLK_DEV=3Dy
>> CONFIG_BLK_DEV_FD=3Dm
>> CONFIG_PARIDE=3Dm
>>
>> #
>> # Parallel IDE high-level drivers
>> #
>> CONFIG_PARIDE_PD=3Dm
>> CONFIG_PARIDE_PCD=3Dm
>> CONFIG_PARIDE_PF=3Dm
>> CONFIG_PARIDE_PT=3Dm
>> CONFIG_PARIDE_PG=3Dm
>>
>> #
>> # Parallel IDE protocol modules
>> #
>> CONFIG_PARIDE_ATEN=3Dm
>> CONFIG_PARIDE_BPCK=3Dm
>> CONFIG_PARIDE_COMM=3Dm
>> CONFIG_PARIDE_DSTR=3Dm
>> CONFIG_PARIDE_FIT2=3Dm
>> CONFIG_PARIDE_FIT3=3Dm
>> CONFIG_PARIDE_EPAT=3Dm
>> CONFIG_PARIDE_EPATC8=3Dy
>> CONFIG_PARIDE_EPIA=3Dm
>> CONFIG_PARIDE_FRIQ=3Dm
>> CONFIG_PARIDE_FRPW=3Dm
>> CONFIG_PARIDE_KBIC=3Dm
>> CONFIG_PARIDE_KTTI=3Dm
>> CONFIG_PARIDE_ON20=3Dm
>> CONFIG_PARIDE_ON26=3Dm
>> CONFIG_BLK_CPQ_DA=3Dm
>> CONFIG_BLK_CPQ_CISS_DA=3Dm
>> CONFIG_CISS_SCSI_TAPE=3Dy
>> CONFIG_BLK_DEV_DAC960=3Dm
>> CONFIG_BLK_DEV_UMEM=3Dm
>> # CONFIG_BLK_DEV_COW_COMMON is not set
>> CONFIG_BLK_DEV_LOOP=3Dy
>> CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
>> # CONFIG_BLK_DEV_DRBD is not set
>> CONFIG_BLK_DEV_NBD=3Dm
>> CONFIG_BLK_DEV_SX8=3Dm
>> # CONFIG_BLK_DEV_UB is not set
>> CONFIG_BLK_DEV_RAM=3Dy
>> CONFIG_BLK_DEV_RAM_COUNT=3D16
>> CONFIG_BLK_DEV_RAM_SIZE=3D16384
>> # CONFIG_BLK_DEV_XIP is not set
>> CONFIG_CDROM_PKTCDVD=3Dm
>> CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
>> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
>> CONFIG_ATA_OVER_ETH=3Dm
>> # CONFIG_BLK_DEV_HD is not set
>> CONFIG_MISC_DEVICES=3Dy
>> # CONFIG_AD525X_DPOT is not set
>> # CONFIG_IBM_ASM is not set
>> # CONFIG_PHANTOM is not set
>> CONFIG_SGI_IOC4=3Dm
>> CONFIG_TIFM_CORE=3Dm
>> CONFIG_TIFM_7XX1=3Dm
>> CONFIG_ICS932S401=3Dm
>> CONFIG_ENCLOSURE_SERVICES=3Dm
>> # CONFIG_CS5535_MFGPT is not set
>> # CONFIG_HP_ILO is not set
>> # CONFIG_ISL29003 is not set
>> CONFIG_SENSORS_TSL2550=3Dm
>> # CONFIG_DS1682 is not set
>> # CONFIG_VMWARE_BALLOON is not set
>> # CONFIG_C2PORT is not set
>>
>> #
>> # EEPROM support
>> #
>> CONFIG_EEPROM_AT24=3Dm
>> CONFIG_EEPROM_LEGACY=3Dm
>> # CONFIG_EEPROM_MAX6875 is not set
>> CONFIG_EEPROM_93CX6=3Dm
>> # CONFIG_CB710_CORE is not set
>> # CONFIG_IWMC3200TOP is not set
>> CONFIG_HAVE_IDE=3Dy
>> # CONFIG_IDE is not set
>>
>> #
>> # SCSI device support
>> #
>> CONFIG_SCSI_MOD=3Dy
>> CONFIG_RAID_ATTRS=3Dm
>> CONFIG_SCSI=3Dy
>> CONFIG_SCSI_DMA=3Dy
>> CONFIG_SCSI_TGT=3Dm
>> CONFIG_SCSI_NETLINK=3Dy
>> CONFIG_SCSI_PROC_FS=3Dy
>>
>> #
>> # SCSI support type (disk, tape, CD-ROM)
>> #
>> CONFIG_BLK_DEV_SD=3Dy
>> CONFIG_CHR_DEV_ST=3Dm
>> CONFIG_CHR_DEV_OSST=3Dm
>> CONFIG_BLK_DEV_SR=3Dy
>> CONFIG_BLK_DEV_SR_VENDOR=3Dy
>> CONFIG_CHR_DEV_SG=3Dy
>> CONFIG_CHR_DEV_SCH=3Dm
>> CONFIG_SCSI_ENCLOSURE=3Dm
>> CONFIG_SCSI_MULTI_LUN=3Dy
>> CONFIG_SCSI_CONSTANTS=3Dy
>> CONFIG_SCSI_LOGGING=3Dy
>> CONFIG_SCSI_SCAN_ASYNC=3Dy
>> CONFIG_SCSI_WAIT_SCAN=3Dm
>>
>> #
>> # SCSI Transports
>> #
>> CONFIG_SCSI_SPI_ATTRS=3Dm
>> CONFIG_SCSI_FC_ATTRS=3Dm
>> CONFIG_SCSI_FC_TGT_ATTRS=3Dy
>> CONFIG_SCSI_ISCSI_ATTRS=3Dm
>> CONFIG_SCSI_SAS_ATTRS=3Dm
>> CONFIG_SCSI_SAS_LIBSAS=3Dm
>> CONFIG_SCSI_SAS_ATA=3Dy
>> CONFIG_SCSI_SAS_HOST_SMP=3Dy
>> # CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
>> CONFIG_SCSI_SRP_ATTRS=3Dm
>> CONFIG_SCSI_SRP_TGT_ATTRS=3Dy
>> CONFIG_SCSI_LOWLEVEL=3Dy
>> CONFIG_ISCSI_TCP=3Dm
>> CONFIG_SCSI_CXGB3_ISCSI=3Dm
>> # CONFIG_SCSI_BNX2_ISCSI is not set
>> # CONFIG_BE2ISCSI is not set
>> CONFIG_BLK_DEV_3W_XXXX_RAID=3Dm
>> # CONFIG_SCSI_HPSA is not set
>> CONFIG_SCSI_3W_9XXX=3Dm
>> # CONFIG_SCSI_3W_SAS is not set
>> CONFIG_SCSI_ACARD=3Dm
>> CONFIG_SCSI_AACRAID=3Dm
>> CONFIG_SCSI_AIC7XXX=3Dm
>> CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D4
>> CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
>> # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
>> CONFIG_AIC7XXX_DEBUG_MASK=3D0
>> # CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
>> CONFIG_SCSI_AIC7XXX_OLD=3Dm
>> CONFIG_SCSI_AIC79XX=3Dm
>> CONFIG_AIC79XX_CMDS_PER_DEVICE=3D4
>> CONFIG_AIC79XX_RESET_DELAY_MS=3D15000
>> # CONFIG_AIC79XX_DEBUG_ENABLE is not set
>> CONFIG_AIC79XX_DEBUG_MASK=3D0
>> # CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
>> CONFIG_SCSI_AIC94XX=3Dm
>> # CONFIG_AIC94XX_DEBUG is not set
>> CONFIG_SCSI_MVSAS=3Dm
>> CONFIG_SCSI_MVSAS_DEBUG=3Dy
>> # CONFIG_SCSI_DPT_I2O is not set
>> # CONFIG_SCSI_ADVANSYS is not set
>> CONFIG_SCSI_ARCMSR=3Dm
>> CONFIG_SCSI_ARCMSR_AER=3Dy
>> CONFIG_MEGARAID_NEWGEN=3Dy
>> CONFIG_MEGARAID_MM=3Dm
>> CONFIG_MEGARAID_MAILBOX=3Dm
>> CONFIG_MEGARAID_LEGACY=3Dm
>> CONFIG_MEGARAID_SAS=3Dm
>> # CONFIG_SCSI_MPT2SAS is not set
>> CONFIG_SCSI_HPTIOP=3Dm
>> CONFIG_SCSI_BUSLOGIC=3Dm
>> # CONFIG_VMWARE_PVSCSI is not set
>> CONFIG_LIBFC=3Dm
>> CONFIG_LIBFCOE=3Dm
>> CONFIG_FCOE=3Dm
>> # CONFIG_FCOE_FNIC is not set
>> # CONFIG_SCSI_DMX3191D is not set
>> # CONFIG_SCSI_EATA is not set
>> # CONFIG_SCSI_FUTURE_DOMAIN is not set
>> CONFIG_SCSI_GDTH=3Dm
>> CONFIG_SCSI_IPS=3Dm
>> CONFIG_SCSI_INITIO=3Dm
>> CONFIG_SCSI_INIA100=3Dm
>> CONFIG_SCSI_PPA=3Dm
>> CONFIG_SCSI_IMM=3Dm
>> # CONFIG_SCSI_IZIP_EPP16 is not set
>> # CONFIG_SCSI_IZIP_SLOW_CTR is not set
>> CONFIG_SCSI_STEX=3Dm
>> CONFIG_SCSI_SYM53C8XX_2=3Dm
>> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
>> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
>> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
>> CONFIG_SCSI_SYM53C8XX_MMIO=3Dy
>> # CONFIG_SCSI_IPR is not set
>> CONFIG_SCSI_QLOGIC_1280=3Dm
>> CONFIG_SCSI_QLA_FC=3Dm
>> CONFIG_SCSI_QLA_ISCSI=3Dm
>> CONFIG_SCSI_LPFC=3Dm
>> # CONFIG_SCSI_LPFC_DEBUG_FS is not set
>> CONFIG_SCSI_DC395x=3Dm
>> CONFIG_SCSI_DC390T=3Dm
>> # CONFIG_SCSI_DEBUG is not set
>> # CONFIG_SCSI_PMCRAID is not set
>> # CONFIG_SCSI_PM8001 is not set
>> CONFIG_SCSI_SRP=3Dm
>> # CONFIG_SCSI_BFA_FC is not set
>> CONFIG_SCSI_LOWLEVEL_PCMCIA=3Dy
>> # CONFIG_PCMCIA_FDOMAIN is not set
>> CONFIG_PCMCIA_QLOGIC=3Dm
>> CONFIG_PCMCIA_SYM53C500=3Dm
>> CONFIG_SCSI_DH=3Dy
>> CONFIG_SCSI_DH_RDAC=3Dm
>> CONFIG_SCSI_DH_HP_SW=3Dm
>> CONFIG_SCSI_DH_EMC=3Dm
>> CONFIG_SCSI_DH_ALUA=3Dm
>> # CONFIG_SCSI_OSD_INITIATOR is not set
>> CONFIG_ATA=3Dy
>> # CONFIG_ATA_NONSTANDARD is not set
>> CONFIG_ATA_VERBOSE_ERROR=3Dy
>> CONFIG_ATA_ACPI=3Dy
>> CONFIG_SATA_PMP=3Dy
>> CONFIG_SATA_AHCI=3Dy
>> CONFIG_SATA_SIL24=3Dm
>> CONFIG_ATA_SFF=3Dy
>> CONFIG_SATA_SVW=3Dm
>> CONFIG_ATA_PIIX=3Dy
>> CONFIG_SATA_MV=3Dm
>> CONFIG_SATA_NV=3Dm
>> CONFIG_PDC_ADMA=3Dm
>> CONFIG_SATA_QSTOR=3Dm
>> CONFIG_SATA_PROMISE=3Dm
>> CONFIG_SATA_SX4=3Dm
>> CONFIG_SATA_SIL=3Dm
>> CONFIG_SATA_SIS=3Dm
>> CONFIG_SATA_ULI=3Dm
>> CONFIG_SATA_VIA=3Dm
>> CONFIG_SATA_VITESSE=3Dm
>> CONFIG_SATA_INIC162X=3Dm
>> CONFIG_PATA_ACPI=3Dm
>> CONFIG_PATA_ALI=3Dm
>> CONFIG_PATA_AMD=3Dm
>> CONFIG_PATA_ARTOP=3Dm
>> # CONFIG_PATA_ATP867X is not set
>> CONFIG_PATA_ATIIXP=3Dm
>> CONFIG_PATA_CMD640_PCI=3Dm
>> CONFIG_PATA_CMD64X=3Dm
>> CONFIG_PATA_CS5520=3Dm
>> CONFIG_PATA_CS5530=3Dm
>> CONFIG_PATA_CYPRESS=3Dm
>> CONFIG_PATA_EFAR=3Dm
>> CONFIG_ATA_GENERIC=3Dm
>> CONFIG_PATA_HPT366=3Dm
>> CONFIG_PATA_HPT37X=3Dm
>> CONFIG_PATA_HPT3X2N=3Dm
>> CONFIG_PATA_HPT3X3=3Dm
>> # CONFIG_PATA_HPT3X3_DMA is not set
>> CONFIG_PATA_IT821X=3Dm
>> CONFIG_PATA_IT8213=3Dm
>> CONFIG_PATA_JMICRON=3Dm
>> # CONFIG_PATA_LEGACY is not set
>> CONFIG_PATA_TRIFLEX=3Dm
>> CONFIG_PATA_MARVELL=3Dm
>> CONFIG_PATA_MPIIX=3Dm
>> CONFIG_PATA_OLDPIIX=3Dm
>> CONFIG_PATA_NETCELL=3Dm
>> CONFIG_PATA_NINJA32=3Dm
>> CONFIG_PATA_NS87410=3Dm
>> CONFIG_PATA_NS87415=3Dm
>> CONFIG_PATA_OPTI=3Dm
>> CONFIG_PATA_OPTIDMA=3Dm
>> CONFIG_PATA_PCMCIA=3Dm
>> CONFIG_PATA_PDC2027X=3Dm
>> CONFIG_PATA_PDC_OLD=3Dm
>> # CONFIG_PATA_RADISYS is not set
>> # CONFIG_PATA_RDC is not set
>> # CONFIG_PATA_RZ1000 is not set
>> # CONFIG_PATA_SC1200 is not set
>> CONFIG_PATA_SERVERWORKS=3Dm
>> CONFIG_PATA_SIL680=3Dm
>> CONFIG_PATA_SIS=3Dm
>> # CONFIG_PATA_TOSHIBA is not set
>> CONFIG_PATA_VIA=3Dm
>> CONFIG_PATA_WINBOND=3Dm
>> CONFIG_PATA_SCH=3Dm
>> CONFIG_MD=3Dy
>> CONFIG_BLK_DEV_MD=3Dy
>> CONFIG_MD_AUTODETECT=3Dy
>> CONFIG_MD_LINEAR=3Dm
>> CONFIG_MD_RAID0=3Dm
>> CONFIG_MD_RAID1=3Dm
>> CONFIG_MD_RAID10=3Dm
>> CONFIG_MD_RAID456=3Dm
>> # CONFIG_MULTICORE_RAID456 is not set
>> CONFIG_MD_RAID6_PQ=3Dm
>> # CONFIG_ASYNC_RAID6_TEST is not set
>> CONFIG_MD_MULTIPATH=3Dm
>> CONFIG_MD_FAULTY=3Dm
>> CONFIG_BLK_DEV_DM=3Dy
>> CONFIG_DM_DEBUG=3Dy
>> CONFIG_DM_CRYPT=3Dm
>> CONFIG_DM_SNAPSHOT=3Dy
>> CONFIG_DM_MIRROR=3Dy
>> # CONFIG_DM_LOG_USERSPACE is not set
>> CONFIG_DM_ZERO=3Dy
>> CONFIG_DM_MULTIPATH=3Dm
>> # CONFIG_DM_MULTIPATH_QL is not set
>> # CONFIG_DM_MULTIPATH_ST is not set
>> # CONFIG_DM_DELAY is not set
>> CONFIG_DM_UEVENT=3Dy
>> CONFIG_FUSION=3Dy
>> CONFIG_FUSION_SPI=3Dm
>> CONFIG_FUSION_FC=3Dm
>> CONFIG_FUSION_SAS=3Dm
>> CONFIG_FUSION_MAX_SGE=3D40
>> CONFIG_FUSION_CTL=3Dm
>> CONFIG_FUSION_LAN=3Dm
>> CONFIG_FUSION_LOGGING=3Dy
>>
>> #
>> # IEEE 1394 (FireWire) support
>> #
>>
>> #
>> # You can enable one or both FireWire driver stacks.
>> #
>>
>> #
>> # The newer stack is recommended.
>> #
>> CONFIG_FIREWIRE=3Dm
>> CONFIG_FIREWIRE_OHCI=3Dm
>> CONFIG_FIREWIRE_OHCI_DEBUG=3Dy
>> CONFIG_FIREWIRE_SBP2=3Dm
>> # CONFIG_FIREWIRE_NET is not set
>> # CONFIG_IEEE1394 is not set
>> CONFIG_I2O=3Dm
>> # CONFIG_I2O_LCT_NOTIFY_ON_CHANGES is not set
>> CONFIG_I2O_EXT_ADAPTEC=3Dy
>> CONFIG_I2O_EXT_ADAPTEC_DMA64=3Dy
>> CONFIG_I2O_CONFIG=3Dm
>> CONFIG_I2O_CONFIG_OLD_IOCTL=3Dy
>> CONFIG_I2O_BUS=3Dm
>> CONFIG_I2O_BLOCK=3Dm
>> CONFIG_I2O_SCSI=3Dm
>> CONFIG_I2O_PROC=3Dm
>> CONFIG_MACINTOSH_DRIVERS=3Dy
>> CONFIG_MAC_EMUMOUSEBTN=3Dy
>> CONFIG_NETDEVICES=3Dy
>> CONFIG_IFB=3Dm
>> CONFIG_DUMMY=3Dm
>> CONFIG_BONDING=3Dm
>> CONFIG_MACVLAN=3Dm
>> # CONFIG_MACVTAP is not set
>> CONFIG_EQUALIZER=3Dm
>> CONFIG_TUN=3Dm
>> CONFIG_VETH=3Dm
>> CONFIG_NET_SB1000=3Dm
>> # CONFIG_ARCNET is not set
>> CONFIG_PHYLIB=3Dy
>>
>> #
>> # MII PHY device drivers
>> #
>> CONFIG_MARVELL_PHY=3Dm
>> CONFIG_DAVICOM_PHY=3Dm
>> CONFIG_QSEMI_PHY=3Dm
>> CONFIG_LXT_PHY=3Dm
>> CONFIG_CICADA_PHY=3Dm
>> CONFIG_VITESSE_PHY=3Dm
>> CONFIG_SMSC_PHY=3Dm
>> CONFIG_BROADCOM_PHY=3Dm
>> CONFIG_ICPLUS_PHY=3Dm
>> CONFIG_REALTEK_PHY=3Dm
>> CONFIG_NATIONAL_PHY=3Dm
>> CONFIG_STE10XP=3Dm
>> CONFIG_LSI_ET1011C_PHY=3Dm
>> # CONFIG_MICREL_PHY is not set
>> CONFIG_FIXED_PHY=3Dy
>> CONFIG_MDIO_BITBANG=3Dm
>> CONFIG_NET_ETHERNET=3Dy
>> CONFIG_MII=3Dm
>> CONFIG_HAPPYMEAL=3Dm
>> CONFIG_SUNGEM=3Dm
>> CONFIG_CASSINI=3Dm
>> CONFIG_NET_VENDOR_3COM=3Dy
>> CONFIG_VORTEX=3Dm
>> CONFIG_TYPHOON=3Dm
>> # CONFIG_ETHOC is not set
>> CONFIG_DNET=3Dm
>> CONFIG_NET_TULIP=3Dy
>> CONFIG_DE2104X=3Dm
>> CONFIG_DE2104X_DSL=3D0
>> CONFIG_TULIP=3Dm
>> # CONFIG_TULIP_MWI is not set
>> CONFIG_TULIP_MMIO=3Dy
>> # CONFIG_TULIP_NAPI is not set
>> CONFIG_DE4X5=3Dm
>> CONFIG_WINBOND_840=3Dm
>> CONFIG_DM9102=3Dm
>> CONFIG_ULI526X=3Dm
>> CONFIG_PCMCIA_XIRCOM=3Dm
>> # CONFIG_HP100 is not set
>> # CONFIG_IBM_NEW_EMAC_ZMII is not set
>> # CONFIG_IBM_NEW_EMAC_RGMII is not set
>> # CONFIG_IBM_NEW_EMAC_TAH is not set
>> # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
>> # CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
>> # CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
>> # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
>> CONFIG_NET_PCI=3Dy
>> CONFIG_PCNET32=3Dm
>> CONFIG_AMD8111_ETH=3Dm
>> CONFIG_ADAPTEC_STARFIRE=3Dm
>> # CONFIG_KSZ884X_PCI is not set
>> CONFIG_B44=3Dm
>> CONFIG_B44_PCI_AUTOSELECT=3Dy
>> CONFIG_B44_PCICORE_AUTOSELECT=3Dy
>> CONFIG_B44_PCI=3Dy
>> CONFIG_FORCEDETH=3Dm
>> CONFIG_FORCEDETH_NAPI=3Dy
>> CONFIG_E100=3Dm
>> CONFIG_FEALNX=3Dm
>> CONFIG_NATSEMI=3Dm
>> CONFIG_NE2K_PCI=3Dm
>> CONFIG_8139CP=3Dm
>> CONFIG_8139TOO=3Dm
>> # CONFIG_8139TOO_PIO is not set
>> # CONFIG_8139TOO_TUNE_TWISTER is not set
>> CONFIG_8139TOO_8129=3Dy
>> # CONFIG_8139_OLD_RX_RESET is not set
>> CONFIG_R6040=3Dm
>> CONFIG_SIS900=3Dm
>> CONFIG_EPIC100=3Dm
>> CONFIG_SMSC9420=3Dm
>> CONFIG_SUNDANCE=3Dm
>> # CONFIG_SUNDANCE_MMIO is not set
>> CONFIG_TLAN=3Dm
>> # CONFIG_KS8842 is not set
>> # CONFIG_KS8851_MLL is not set
>> CONFIG_VIA_RHINE=3Dm
>> CONFIG_VIA_RHINE_MMIO=3Dy
>> CONFIG_SC92031=3Dm
>> CONFIG_NET_POCKET=3Dy
>> CONFIG_ATP=3Dm
>> CONFIG_DE600=3Dm
>> CONFIG_DE620=3Dm
>> CONFIG_ATL2=3Dm
>> CONFIG_NETDEV_1000=3Dy
>> CONFIG_ACENIC=3Dm
>> # CONFIG_ACENIC_OMIT_TIGON_I is not set
>> CONFIG_DL2K=3Dm
>> CONFIG_E1000=3Dm
>> CONFIG_E1000E=3Dm
>> CONFIG_IP1000=3Dm
>> CONFIG_IGB=3Dm
>> CONFIG_IGB_DCA=3Dy
>> # CONFIG_IGBVF is not set
>> CONFIG_NS83820=3Dm
>> CONFIG_HAMACHI=3Dm
>> CONFIG_YELLOWFIN=3Dm
>> CONFIG_R8169=3Dm
>> CONFIG_R8169_VLAN=3Dy
>> CONFIG_SIS190=3Dm
>> CONFIG_SKGE=3Dm
>> # CONFIG_SKGE_DEBUG is not set
>> CONFIG_SKY2=3Dm
>> # CONFIG_SKY2_DEBUG is not set
>> CONFIG_VIA_VELOCITY=3Dm
>> CONFIG_TIGON3=3Dm
>> CONFIG_BNX2=3Dm
>> # CONFIG_CNIC is not set
>> CONFIG_QLA3XXX=3Dm
>> CONFIG_ATL1=3Dm
>> CONFIG_ATL1E=3Dm
>> CONFIG_ATL1C=3Dm
>> CONFIG_JME=3Dm
>> CONFIG_NETDEV_10000=3Dy
>> CONFIG_MDIO=3Dm
>> CONFIG_CHELSIO_T1=3Dm
>> CONFIG_CHELSIO_T1_1G=3Dy
>> CONFIG_CHELSIO_T3_DEPENDS=3Dy
>> CONFIG_CHELSIO_T3=3Dm
>> CONFIG_CHELSIO_T4_DEPENDS=3Dy
>> # CONFIG_CHELSIO_T4 is not set
>> CONFIG_ENIC=3Dm
>> CONFIG_IXGBE=3Dm
>> CONFIG_IXGBE_DCA=3Dy
>> CONFIG_IXGBE_DCB=3Dy
>> # CONFIG_IXGBEVF is not set
>> CONFIG_IXGB=3Dm
>> CONFIG_S2IO=3Dm
>> # CONFIG_VXGE is not set
>> CONFIG_MYRI10GE=3Dm
>> CONFIG_MYRI10GE_DCA=3Dy
>> CONFIG_NETXEN_NIC=3Dm
>> CONFIG_NIU=3Dm
>> CONFIG_MLX4_EN=3Dm
>> CONFIG_MLX4_CORE=3Dm
>> CONFIG_MLX4_DEBUG=3Dy
>> CONFIG_TEHUTI=3Dm
>> CONFIG_BNX2X=3Dm
>> # CONFIG_QLCNIC is not set
>> CONFIG_QLGE=3Dm
>> CONFIG_SFC=3Dm
>> CONFIG_SFC_MTD=3Dy
>> CONFIG_BE2NET=3Dm
>> # CONFIG_TR is not set
>> CONFIG_WLAN=3Dy
>> # CONFIG_PCMCIA_RAYCS is not set
>> CONFIG_LIBERTAS_THINFIRM=3Dm
>> CONFIG_LIBERTAS_THINFIRM_USB=3Dm
>> CONFIG_AIRO=3Dm
>> CONFIG_ATMEL=3Dm
>> CONFIG_PCI_ATMEL=3Dm
>> CONFIG_PCMCIA_ATMEL=3Dm
>> # CONFIG_AT76C50X_USB is not set
>> CONFIG_AIRO_CS=3Dm
>> CONFIG_PCMCIA_WL3501=3Dm
>> CONFIG_PRISM54=3Dm
>> CONFIG_USB_ZD1201=3Dm
>> CONFIG_USB_NET_RNDIS_WLAN=3Dm
>> CONFIG_RTL8180=3Dm
>> CONFIG_RTL8187=3Dm
>> CONFIG_RTL8187_LEDS=3Dy
>> CONFIG_ADM8211=3Dm
>> CONFIG_MAC80211_HWSIM=3Dm
>> # CONFIG_MWL8K is not set
>> # CONFIG_ATH_COMMON is not set
>> CONFIG_B43=3Dm
>> CONFIG_B43_PCI_AUTOSELECT=3Dy
>> CONFIG_B43_PCICORE_AUTOSELECT=3Dy
>> CONFIG_B43_PCMCIA=3Dy
>> # CONFIG_B43_SDIO is not set
>> CONFIG_B43_PIO=3Dy
>> CONFIG_B43_PHY_LP=3Dy
>> CONFIG_B43_LEDS=3Dy
>> CONFIG_B43_HWRNG=3Dy
>> # CONFIG_B43_DEBUG is not set
>> CONFIG_B43LEGACY=3Dm
>> CONFIG_B43LEGACY_PCI_AUTOSELECT=3Dy
>> CONFIG_B43LEGACY_PCICORE_AUTOSELECT=3Dy
>> CONFIG_B43LEGACY_LEDS=3Dy
>> CONFIG_B43LEGACY_HWRNG=3Dy
>> # CONFIG_B43LEGACY_DEBUG is not set
>> CONFIG_B43LEGACY_DMA=3Dy
>> CONFIG_B43LEGACY_PIO=3Dy
>> CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy
>> # CONFIG_B43LEGACY_DMA_MODE is not set
>> # CONFIG_B43LEGACY_PIO_MODE is not set
>> CONFIG_HOSTAP=3Dm
>> CONFIG_HOSTAP_FIRMWARE=3Dy
>> CONFIG_HOSTAP_FIRMWARE_NVRAM=3Dy
>> CONFIG_HOSTAP_PLX=3Dm
>> CONFIG_HOSTAP_PCI=3Dm
>> CONFIG_HOSTAP_CS=3Dm
>> CONFIG_IPW2100=3Dm
>> CONFIG_IPW2100_MONITOR=3Dy
>> # CONFIG_IPW2100_DEBUG is not set
>> CONFIG_IPW2200=3Dm
>> CONFIG_IPW2200_MONITOR=3Dy
>> CONFIG_IPW2200_RADIOTAP=3Dy
>> CONFIG_IPW2200_PROMISCUOUS=3Dy
>> CONFIG_IPW2200_QOS=3Dy
>> # CONFIG_IPW2200_DEBUG is not set
>> CONFIG_LIBIPW=3Dm
>> # CONFIG_LIBIPW_DEBUG is not set
>> CONFIG_IWLWIFI=3Dm
>> CONFIG_IWLWIFI_DEBUG=3Dy
>> CONFIG_IWLWIFI_DEBUGFS=3Dy
>> # CONFIG_IWLWIFI_DEVICE_TRACING is not set
>> CONFIG_IWLAGN=3Dm
>> CONFIG_IWL4965=3Dy
>> CONFIG_IWL5000=3Dy
>> CONFIG_IWL3945=3Dm
>> # CONFIG_IWM is not set
>> CONFIG_LIBERTAS=3Dm
>> CONFIG_LIBERTAS_USB=3Dm
>> CONFIG_LIBERTAS_CS=3Dm
>> CONFIG_LIBERTAS_SDIO=3Dm
>> CONFIG_LIBERTAS_DEBUG=3Dy
>> # CONFIG_LIBERTAS_MESH is not set
>> CONFIG_HERMES=3Dm
>> CONFIG_HERMES_CACHE_FW_ON_INIT=3Dy
>> CONFIG_PLX_HERMES=3Dm
>> CONFIG_TMD_HERMES=3Dm
>> CONFIG_NORTEL_HERMES=3Dm
>> CONFIG_PCI_HERMES=3Dm
>> CONFIG_PCMCIA_HERMES=3Dm
>> CONFIG_PCMCIA_SPECTRUM=3Dm
>> CONFIG_P54_COMMON=3Dm
>> CONFIG_P54_USB=3Dm
>> CONFIG_P54_PCI=3Dm
>> CONFIG_P54_LEDS=3Dy
>> CONFIG_RT2X00=3Dm
>> CONFIG_RT2400PCI=3Dm
>> CONFIG_RT2500PCI=3Dm
>> CONFIG_RT61PCI=3Dm
>> CONFIG_RT2800PCI_PCI=3Dy
>> # CONFIG_RT2800PCI is not set
>> CONFIG_RT2500USB=3Dm
>> CONFIG_RT73USB=3Dm
>> # CONFIG_RT2800USB is not set
>> CONFIG_RT2X00_LIB_PCI=3Dm
>> CONFIG_RT2X00_LIB_USB=3Dm
>> CONFIG_RT2X00_LIB=3Dm
>> CONFIG_RT2X00_LIB_FIRMWARE=3Dy
>> CONFIG_RT2X00_LIB_CRYPTO=3Dy
>> CONFIG_RT2X00_LIB_LEDS=3Dy
>> CONFIG_RT2X00_LIB_DEBUGFS=3Dy
>> # CONFIG_RT2X00_DEBUG is not set
>> # CONFIG_WL12XX is not set
>> CONFIG_ZD1211RW=3Dm
>> # CONFIG_ZD1211RW_DEBUG is not set
>>
>> #
>> # WiMAX Wireless Broadband devices
>> #
>> CONFIG_WIMAX_I2400M=3Dm
>> CONFIG_WIMAX_I2400M_USB=3Dm
>> CONFIG_WIMAX_I2400M_SDIO=3Dm
>> # CONFIG_WIMAX_IWMC3200_SDIO is not set
>> CONFIG_WIMAX_I2400M_DEBUG_LEVEL=3D8
>>
>> #
>> # USB Network Adapters
>> #
>> CONFIG_USB_CATC=3Dm
>> CONFIG_USB_KAWETH=3Dm
>> CONFIG_USB_PEGASUS=3Dm
>> CONFIG_USB_RTL8150=3Dm
>> CONFIG_USB_USBNET=3Dm
>> CONFIG_USB_NET_AX8817X=3Dm
>> CONFIG_USB_NET_CDCETHER=3Dm
>> # CONFIG_USB_NET_CDC_EEM is not set
>> CONFIG_USB_NET_DM9601=3Dm
>> # CONFIG_USB_NET_SMSC75XX is not set
>> CONFIG_USB_NET_SMSC95XX=3Dm
>> CONFIG_USB_NET_GL620A=3Dm
>> CONFIG_USB_NET_NET1080=3Dm
>> CONFIG_USB_NET_PLUSB=3Dm
>> CONFIG_USB_NET_MCS7830=3Dm
>> CONFIG_USB_NET_RNDIS_HOST=3Dm
>> CONFIG_USB_NET_CDC_SUBSET=3Dm
>> CONFIG_USB_ALI_M5632=3Dy
>> CONFIG_USB_AN2720=3Dy
>> CONFIG_USB_BELKIN=3Dy
>> CONFIG_USB_ARMLINUX=3Dy
>> CONFIG_USB_EPSON2888=3Dy
>> CONFIG_USB_KC2190=3Dy
>> CONFIG_USB_NET_ZAURUS=3Dm
>> CONFIG_USB_HSO=3Dm
>> # CONFIG_USB_NET_INT51X1 is not set
>> # CONFIG_USB_CDC_PHONET is not set
>> # CONFIG_USB_IPHETH is not set
>> # CONFIG_USB_SIERRA_NET is not set
>> CONFIG_NET_PCMCIA=3Dy
>> CONFIG_PCMCIA_3C589=3Dm
>> CONFIG_PCMCIA_3C574=3Dm
>> CONFIG_PCMCIA_FMVJ18X=3Dm
>> CONFIG_PCMCIA_PCNET=3Dm
>> CONFIG_PCMCIA_NMCLAN=3Dm
>> CONFIG_PCMCIA_SMC91C92=3Dm
>> CONFIG_PCMCIA_XIRC2PS=3Dm
>> CONFIG_PCMCIA_AXNET=3Dm
>> # CONFIG_WAN is not set
>> CONFIG_ATM_DRIVERS=3Dy
>> # CONFIG_ATM_DUMMY is not set
>> CONFIG_ATM_TCP=3Dm
>> # CONFIG_ATM_LANAI is not set
>> CONFIG_ATM_ENI=3Dm
>> # CONFIG_ATM_ENI_DEBUG is not set
>> # CONFIG_ATM_ENI_TUNE_BURST is not set
>> CONFIG_ATM_FIRESTREAM=3Dm
>> # CONFIG_ATM_ZATM is not set
>> # CONFIG_ATM_IDT77252 is not set
>> # CONFIG_ATM_AMBASSADOR is not set
>> # CONFIG_ATM_HORIZON is not set
>> # CONFIG_ATM_IA is not set
>> # CONFIG_ATM_FORE200E is not set
>> # CONFIG_ATM_HE is not set
>> # CONFIG_ATM_SOLOS is not set
>> CONFIG_FDDI=3Dy
>> # CONFIG_DEFXX is not set
>> CONFIG_SKFP=3Dm
>> # CONFIG_HIPPI is not set
>> CONFIG_PLIP=3Dm
>> CONFIG_PPP=3Dm
>> CONFIG_PPP_MULTILINK=3Dy
>> CONFIG_PPP_FILTER=3Dy
>> CONFIG_PPP_ASYNC=3Dm
>> CONFIG_PPP_SYNC_TTY=3Dm
>> CONFIG_PPP_DEFLATE=3Dm
>> # CONFIG_PPP_BSDCOMP is not set
>> CONFIG_PPP_MPPE=3Dm
>> CONFIG_PPPOE=3Dm
>> CONFIG_PPPOATM=3Dm
>> CONFIG_PPPOL2TP=3Dm
>> CONFIG_SLIP=3Dm
>> CONFIG_SLIP_COMPRESSED=3Dy
>> CONFIG_SLHC=3Dm
>> CONFIG_SLIP_SMART=3Dy
>> # CONFIG_SLIP_MODE_SLIP6 is not set
>> CONFIG_NET_FC=3Dy
>> CONFIG_NETCONSOLE=3Dm
>> CONFIG_NETCONSOLE_DYNAMIC=3Dy
>> CONFIG_NETPOLL=3Dy
>> CONFIG_NETPOLL_TRAP=3Dy
>> CONFIG_NET_POLL_CONTROLLER=3Dy
>> # CONFIG_VMXNET3 is not set
>> CONFIG_ISDN=3Dy
>> CONFIG_ISDN_I4L=3Dm
>> CONFIG_ISDN_PPP=3Dy
>> CONFIG_ISDN_PPP_VJ=3Dy
>> CONFIG_ISDN_MPP=3Dy
>> CONFIG_IPPP_FILTER=3Dy
>> # CONFIG_ISDN_PPP_BSDCOMP is not set
>> CONFIG_ISDN_AUDIO=3Dy
>> CONFIG_ISDN_TTY_FAX=3Dy
>>
>> #
>> # ISDN feature submodules
>> #
>> CONFIG_ISDN_DIVERSION=3Dm
>>
>> #
>> # ISDN4Linux hardware drivers
>> #
>>
>> #
>> # Passive cards
>> #
>> CONFIG_ISDN_DRV_HISAX=3Dm
>>
>> #
>> # D-channel protocol features
>> #
>> CONFIG_HISAX_EURO=3Dy
>> CONFIG_DE_AOC=3Dy
>> CONFIG_HISAX_NO_SENDCOMPLETE=3Dy
>> CONFIG_HISAX_NO_LLC=3Dy
>> CONFIG_HISAX_NO_KEYPAD=3Dy
>> CONFIG_HISAX_1TR6=3Dy
>> CONFIG_HISAX_NI1=3Dy
>> CONFIG_HISAX_MAX_CARDS=3D8
>>
>> #
>> # HiSax supported cards
>> #
>> CONFIG_HISAX_16_3=3Dy
>> CONFIG_HISAX_TELESPCI=3Dy
>> CONFIG_HISAX_S0BOX=3Dy
>> CONFIG_HISAX_FRITZPCI=3Dy
>> CONFIG_HISAX_AVM_A1_PCMCIA=3Dy
>> CONFIG_HISAX_ELSA=3Dy
>> CONFIG_HISAX_DIEHLDIVA=3Dy
>> CONFIG_HISAX_SEDLBAUER=3Dy
>> CONFIG_HISAX_NETJET=3Dy
>> CONFIG_HISAX_NETJET_U=3Dy
>> CONFIG_HISAX_NICCY=3Dy
>> CONFIG_HISAX_BKM_A4T=3Dy
>> CONFIG_HISAX_SCT_QUADRO=3Dy
>> CONFIG_HISAX_GAZEL=3Dy
>> CONFIG_HISAX_HFC_PCI=3Dy
>> CONFIG_HISAX_W6692=3Dy
>> CONFIG_HISAX_HFC_SX=3Dy
>> CONFIG_HISAX_ENTERNOW_PCI=3Dy
>> # CONFIG_HISAX_DEBUG is not set
>>
>> #
>> # HiSax PCMCIA card service modules
>> #
>> CONFIG_HISAX_SEDLBAUER_CS=3Dm
>> CONFIG_HISAX_ELSA_CS=3Dm
>> CONFIG_HISAX_AVM_A1_CS=3Dm
>> CONFIG_HISAX_TELES_CS=3Dm
>>
>> #
>> # HiSax sub driver modules
>> #
>> CONFIG_HISAX_ST5481=3Dm
>> # CONFIG_HISAX_HFCUSB is not set
>> CONFIG_HISAX_HFC4S8S=3Dm
>> CONFIG_HISAX_FRITZ_PCIPNP=3Dm
>>
>> #
>> # Active cards
>> #
>> CONFIG_ISDN_CAPI=3Dm
>> CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=3Dy
>> # CONFIG_CAPI_TRACE is not set
>> CONFIG_ISDN_CAPI_MIDDLEWARE=3Dy
>> CONFIG_ISDN_CAPI_CAPI20=3Dm
>> CONFIG_ISDN_CAPI_CAPIFS_BOOL=3Dy
>> CONFIG_ISDN_CAPI_CAPIFS=3Dm
>> CONFIG_ISDN_CAPI_CAPIDRV=3Dm
>>
>> #
>> # CAPI hardware drivers
>> #
>> CONFIG_CAPI_AVM=3Dy
>> CONFIG_ISDN_DRV_AVMB1_B1PCI=3Dm
>> CONFIG_ISDN_DRV_AVMB1_B1PCIV4=3Dy
>> CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=3Dm
>> CONFIG_ISDN_DRV_AVMB1_AVM_CS=3Dm
>> CONFIG_ISDN_DRV_AVMB1_T1PCI=3Dm
>> CONFIG_ISDN_DRV_AVMB1_C4=3Dm
>> CONFIG_CAPI_EICON=3Dy
>> CONFIG_ISDN_DIVAS=3Dm
>> CONFIG_ISDN_DIVAS_BRIPCI=3Dy
>> CONFIG_ISDN_DIVAS_PRIPCI=3Dy
>> CONFIG_ISDN_DIVAS_DIVACAPI=3Dm
>> CONFIG_ISDN_DIVAS_USERIDI=3Dm
>> CONFIG_ISDN_DIVAS_MAINT=3Dm
>> CONFIG_ISDN_DRV_GIGASET=3Dm
>> # CONFIG_GIGASET_CAPI is not set
>> CONFIG_GIGASET_I4L=3Dy
>> # CONFIG_GIGASET_DUMMYLL is not set
>> CONFIG_GIGASET_BASE=3Dm
>> CONFIG_GIGASET_M105=3Dm
>> CONFIG_GIGASET_M101=3Dm
>> # CONFIG_GIGASET_DEBUG is not set
>> CONFIG_HYSDN=3Dm
>> CONFIG_HYSDN_CAPI=3Dy
>> CONFIG_MISDN=3Dm
>> CONFIG_MISDN_DSP=3Dm
>> CONFIG_MISDN_L1OIP=3Dm
>>
>> #
>> # mISDN hardware drivers
>> #
>> CONFIG_MISDN_HFCPCI=3Dm
>> CONFIG_MISDN_HFCMULTI=3Dm
>> CONFIG_MISDN_HFCUSB=3Dm
>> # CONFIG_MISDN_AVMFRITZ is not set
>> # CONFIG_MISDN_SPEEDFAX is not set
>> # CONFIG_MISDN_INFINEON is not set
>> # CONFIG_MISDN_W6692 is not set
>> # CONFIG_MISDN_NETJET is not set
>> CONFIG_ISDN_HDLC=3Dm
>> # CONFIG_PHONE is not set
>>
>> #
>> # Input device support
>> #
>> CONFIG_INPUT=3Dy
>> CONFIG_INPUT_FF_MEMLESS=3Dy
>> CONFIG_INPUT_POLLDEV=3Dm
>> CONFIG_INPUT_SPARSEKMAP=3Dm
>>
>> #
>> # Userland interfaces
>> #
>> CONFIG_INPUT_MOUSEDEV=3Dy
>> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
>> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
>> CONFIG_INPUT_JOYDEV=3Dm
>> CONFIG_INPUT_EVDEV=3Dy
>> # CONFIG_INPUT_EVBUG is not set
>>
>> #
>> # Input Device Drivers
>> #
>> CONFIG_INPUT_KEYBOARD=3Dy
>> # CONFIG_KEYBOARD_ADP5588 is not set
>> CONFIG_KEYBOARD_ATKBD=3Dy
>> # CONFIG_QT2160 is not set
>> # CONFIG_KEYBOARD_LKKBD is not set
>> # CONFIG_KEYBOARD_LM8323 is not set
>> # CONFIG_KEYBOARD_MAX7359 is not set
>> # CONFIG_KEYBOARD_NEWTON is not set
>> # CONFIG_KEYBOARD_OPENCORES is not set
>> # CONFIG_KEYBOARD_STOWAWAY is not set
>> # CONFIG_KEYBOARD_SUNKBD is not set
>> # CONFIG_KEYBOARD_XTKBD is not set
>> CONFIG_INPUT_MOUSE=3Dy
>> CONFIG_MOUSE_PS2=3Dy
>> CONFIG_MOUSE_PS2_ALPS=3Dy
>> CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
>> CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
>> CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
>> CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
>> CONFIG_MOUSE_PS2_ELANTECH=3Dy
>> # CONFIG_MOUSE_PS2_SENTELIC is not set
>> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
>> CONFIG_MOUSE_SERIAL=3Dm
>> CONFIG_MOUSE_APPLETOUCH=3Dm
>> CONFIG_MOUSE_BCM5974=3Dm
>> CONFIG_MOUSE_VSXXXAA=3Dm
>> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
>> CONFIG_INPUT_JOYSTICK=3Dy
>> CONFIG_JOYSTICK_ANALOG=3Dm
>> CONFIG_JOYSTICK_A3D=3Dm
>> CONFIG_JOYSTICK_ADI=3Dm
>> CONFIG_JOYSTICK_COBRA=3Dm
>> CONFIG_JOYSTICK_GF2K=3Dm
>> CONFIG_JOYSTICK_GRIP=3Dm
>> CONFIG_JOYSTICK_GRIP_MP=3Dm
>> CONFIG_JOYSTICK_GUILLEMOT=3Dm
>> CONFIG_JOYSTICK_INTERACT=3Dm
>> CONFIG_JOYSTICK_SIDEWINDER=3Dm
>> CONFIG_JOYSTICK_TMDC=3Dm
>> CONFIG_JOYSTICK_IFORCE=3Dm
>> CONFIG_JOYSTICK_IFORCE_USB=3Dy
>> CONFIG_JOYSTICK_IFORCE_232=3Dy
>> CONFIG_JOYSTICK_WARRIOR=3Dm
>> CONFIG_JOYSTICK_MAGELLAN=3Dm
>> CONFIG_JOYSTICK_SPACEORB=3Dm
>> CONFIG_JOYSTICK_SPACEBALL=3Dm
>> CONFIG_JOYSTICK_STINGER=3Dm
>> CONFIG_JOYSTICK_TWIDJOY=3Dm
>> CONFIG_JOYSTICK_ZHENHUA=3Dm
>> CONFIG_JOYSTICK_DB9=3Dm
>> CONFIG_JOYSTICK_GAMECON=3Dm
>> CONFIG_JOYSTICK_TURBOGRAFX=3Dm
>> CONFIG_JOYSTICK_JOYDUMP=3Dm
>> CONFIG_JOYSTICK_XPAD=3Dm
>> CONFIG_JOYSTICK_XPAD_FF=3Dy
>> CONFIG_JOYSTICK_XPAD_LEDS=3Dy
>> CONFIG_INPUT_TABLET=3Dy
>> CONFIG_TABLET_USB_ACECAD=3Dm
>> CONFIG_TABLET_USB_AIPTEK=3Dm
>> CONFIG_TABLET_USB_GTCO=3Dm
>> CONFIG_TABLET_USB_KBTAB=3Dm
>> CONFIG_TABLET_USB_WACOM=3Dm
>> CONFIG_INPUT_TOUCHSCREEN=3Dy
>> # CONFIG_TOUCHSCREEN_AD7879_I2C is not set
>> # CONFIG_TOUCHSCREEN_AD7879 is not set
>> # CONFIG_TOUCHSCREEN_DYNAPRO is not set
>> # CONFIG_TOUCHSCREEN_EETI is not set
>> CONFIG_TOUCHSCREEN_FUJITSU=3Dm
>> CONFIG_TOUCHSCREEN_GUNZE=3Dm
>> CONFIG_TOUCHSCREEN_ELO=3Dm
>> CONFIG_TOUCHSCREEN_WACOM_W8001=3Dm
>> # CONFIG_TOUCHSCREEN_MCS5000 is not set
>> CONFIG_TOUCHSCREEN_MTOUCH=3Dm
>> CONFIG_TOUCHSCREEN_INEXIO=3Dm
>> CONFIG_TOUCHSCREEN_MK712=3Dm
>> CONFIG_TOUCHSCREEN_PENMOUNT=3Dm
>> CONFIG_TOUCHSCREEN_TOUCHRIGHT=3Dm
>> CONFIG_TOUCHSCREEN_TOUCHWIN=3Dm
>> # CONFIG_TOUCHSCREEN_WM97XX is not set
>> CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dm
>> CONFIG_TOUCHSCREEN_USB_EGALAX=3Dy
>> CONFIG_TOUCHSCREEN_USB_PANJIT=3Dy
>> CONFIG_TOUCHSCREEN_USB_3M=3Dy
>> CONFIG_TOUCHSCREEN_USB_ITM=3Dy
>> CONFIG_TOUCHSCREEN_USB_ETURBO=3Dy
>> CONFIG_TOUCHSCREEN_USB_GUNZE=3Dy
>> CONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy
>> CONFIG_TOUCHSCREEN_USB_IRTOUCH=3Dy
>> CONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy
>> CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=3Dy
>> CONFIG_TOUCHSCREEN_USB_GOTOP=3Dy
>> CONFIG_TOUCHSCREEN_USB_JASTEC=3Dy
>> CONFIG_TOUCHSCREEN_USB_E2I=3Dy
>> CONFIG_TOUCHSCREEN_USB_ZYTRONIC=3Dy
>> CONFIG_TOUCHSCREEN_USB_ETT_TC5UH=3Dy
>> CONFIG_TOUCHSCREEN_USB_NEXIO=3Dy
>> CONFIG_TOUCHSCREEN_TOUCHIT213=3Dm
>> CONFIG_TOUCHSCREEN_TSC2007=3Dm
>> CONFIG_INPUT_MISC=3Dy
>> CONFIG_INPUT_PCSPKR=3Dm
>> CONFIG_INPUT_APANEL=3Dm
>> CONFIG_INPUT_ATLAS_BTNS=3Dm
>> CONFIG_INPUT_ATI_REMOTE=3Dm
>> CONFIG_INPUT_ATI_REMOTE2=3Dm
>> CONFIG_INPUT_KEYSPAN_REMOTE=3Dm
>> CONFIG_INPUT_POWERMATE=3Dm
>> CONFIG_INPUT_YEALINK=3Dm
>> CONFIG_INPUT_CM109=3Dm
>> CONFIG_INPUT_UINPUT=3Dm
>> # CONFIG_INPUT_WINBOND_CIR is not set
>>
>> #
>> # Hardware I/O ports
>> #
>> CONFIG_SERIO=3Dy
>> CONFIG_SERIO_I8042=3Dy
>> CONFIG_SERIO_SERPORT=3Dy
>> # CONFIG_SERIO_CT82C710 is not set
>> # CONFIG_SERIO_PARKBD is not set
>> # CONFIG_SERIO_PCIPS2 is not set
>> CONFIG_SERIO_LIBPS2=3Dy
>> CONFIG_SERIO_RAW=3Dm
>> # CONFIG_SERIO_ALTERA_PS2 is not set
>> CONFIG_GAMEPORT=3Dm
>> CONFIG_GAMEPORT_NS558=3Dm
>> CONFIG_GAMEPORT_L4=3Dm
>> CONFIG_GAMEPORT_EMU10K1=3Dm
>> CONFIG_GAMEPORT_FM801=3Dm
>>
>> #
>> # Character devices
>> #
>> CONFIG_VT=3Dy
>> CONFIG_CONSOLE_TRANSLATIONS=3Dy
>> CONFIG_VT_CONSOLE=3Dy
>> CONFIG_HW_CONSOLE=3Dy
>> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
>> # CONFIG_DEVKMEM is not set
>> CONFIG_SERIAL_NONSTANDARD=3Dy
>> # CONFIG_COMPUTONE is not set
>> CONFIG_ROCKETPORT=3Dm
>> CONFIG_CYCLADES=3Dm
>> # CONFIG_CYZ_INTR is not set
>> # CONFIG_DIGIEPCA is not set
>> # CONFIG_MOXA_INTELLIO is not set
>> # CONFIG_MOXA_SMARTIO is not set
>> # CONFIG_ISI is not set
>> CONFIG_SYNCLINK=3Dm
>> CONFIG_SYNCLINKMP=3Dm
>> CONFIG_SYNCLINK_GT=3Dm
>> CONFIG_N_HDLC=3Dm
>> # CONFIG_RISCOM8 is not set
>> # CONFIG_SPECIALIX is not set
>> # CONFIG_STALDRV is not set
>> CONFIG_NOZOMI=3Dm
>>
>> #
>> # Serial drivers
>> #
>> CONFIG_SERIAL_8250=3Dy
>> CONFIG_SERIAL_8250_CONSOLE=3Dy
>> CONFIG_FIX_EARLYCON_MEM=3Dy
>> CONFIG_SERIAL_8250_PCI=3Dy
>> CONFIG_SERIAL_8250_PNP=3Dy
>> CONFIG_SERIAL_8250_CS=3Dm
>> CONFIG_SERIAL_8250_NR_UARTS=3D32
>> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
>> CONFIG_SERIAL_8250_EXTENDED=3Dy
>> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
>> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
>> CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
>> CONFIG_SERIAL_8250_RSA=3Dy
>>
>> #
>> # Non-8250 serial port support
>> #
>> CONFIG_SERIAL_CORE=3Dy
>> CONFIG_SERIAL_CORE_CONSOLE=3Dy
>> CONFIG_CONSOLE_POLL=3Dy
>> CONFIG_SERIAL_JSM=3Dm
>> # CONFIG_SERIAL_TIMBERDALE is not set
>> CONFIG_UNIX98_PTYS=3Dy
>> CONFIG_DEVPTS_MULTIPLE_INSTANCES=3Dy
>> # CONFIG_LEGACY_PTYS is not set
>> CONFIG_PRINTER=3Dm
>> CONFIG_LP_CONSOLE=3Dy
>> CONFIG_PPDEV=3Dm
>> CONFIG_IPMI_HANDLER=3Dm
>> # CONFIG_IPMI_PANIC_EVENT is not set
>> CONFIG_IPMI_DEVICE_INTERFACE=3Dm
>> CONFIG_IPMI_SI=3Dm
>> CONFIG_IPMI_WATCHDOG=3Dm
>> CONFIG_IPMI_POWEROFF=3Dm
>> CONFIG_HW_RANDOM=3Dy
>> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
>> CONFIG_HW_RANDOM_INTEL=3Dm
>> CONFIG_HW_RANDOM_AMD=3Dm
>> CONFIG_HW_RANDOM_VIA=3Dy
>> CONFIG_NVRAM=3Dy
>> CONFIG_R3964=3Dm
>> # CONFIG_APPLICOM is not set
>>
>> #
>> # PCMCIA character devices
>> #
>> # CONFIG_SYNCLINK_CS is not set
>> CONFIG_CARDMAN_4000=3Dm
>> CONFIG_CARDMAN_4040=3Dm
>> CONFIG_IPWIRELESS=3Dm
>> CONFIG_MWAVE=3Dm
>> # CONFIG_PC8736x_GPIO is not set
>> CONFIG_RAW_DRIVER=3Dy
>> CONFIG_MAX_RAW_DEVS=3D8192
>> CONFIG_HPET=3Dy
>> # CONFIG_HPET_MMAP is not set
>> CONFIG_HANGCHECK_TIMER=3Dm
>> CONFIG_TCG_TPM=3Dm
>> CONFIG_TCG_TIS=3Dm
>> CONFIG_TCG_NSC=3Dm
>> CONFIG_TCG_ATMEL=3Dm
>> CONFIG_TCG_INFINEON=3Dm
>> CONFIG_TELCLOCK=3Dm
>> CONFIG_DEVPORT=3Dy
>> CONFIG_I2C=3Dm
>> CONFIG_I2C_BOARDINFO=3Dy
>> # CONFIG_I2C_COMPAT is not set
>> # CONFIG_I2C_CHARDEV is not set
>> # CONFIG_I2C_HELPER_AUTO is not set
>> CONFIG_I2C_SMBUS=3Dm
>>
>> #
>> # I2C Algorithms
>> #
>> CONFIG_I2C_ALGOBIT=3Dm
>> # CONFIG_I2C_ALGOPCF is not set
>> CONFIG_I2C_ALGOPCA=3Dm
>>
>> #
>> # I2C Hardware Bus support
>> #
>>
>> #
>> # PC SMBus host controller drivers
>> #
>> # CONFIG_I2C_ALI1535 is not set
>> # CONFIG_I2C_ALI1563 is not set
>> # CONFIG_I2C_ALI15X3 is not set
>> CONFIG_I2C_AMD756=3Dm
>> CONFIG_I2C_AMD756_S4882=3Dm
>> CONFIG_I2C_AMD8111=3Dm
>> CONFIG_I2C_I801=3Dm
>> CONFIG_I2C_ISCH=3Dm
>> CONFIG_I2C_PIIX4=3Dm
>> CONFIG_I2C_NFORCE2=3Dm
>> CONFIG_I2C_NFORCE2_S4985=3Dm
>> # CONFIG_I2C_SIS5595 is not set
>> # CONFIG_I2C_SIS630 is not set
>> CONFIG_I2C_SIS96X=3Dm
>> CONFIG_I2C_VIA=3Dm
>> CONFIG_I2C_VIAPRO=3Dm
>>
>> #
>> # ACPI drivers
>> #
>> # CONFIG_I2C_SCMI is not set
>>
>> #
>> # I2C system bus drivers (mostly embedded / system-on-chip)
>> #
>> # CONFIG_I2C_OCORES is not set
>> CONFIG_I2C_SIMTEC=3Dm
>> # CONFIG_I2C_XILINX is not set
>>
>> #
>> # External I2C/SMBus adapter drivers
>> #
>> CONFIG_I2C_PARPORT=3Dm
>> CONFIG_I2C_PARPORT_LIGHT=3Dm
>> # CONFIG_I2C_TAOS_EVM is not set
>> CONFIG_I2C_TINY_USB=3Dm
>>
>> #
>> # Other I2C/SMBus bus drivers
>> #
>> CONFIG_I2C_PCA_PLATFORM=3Dm
>> CONFIG_I2C_STUB=3Dm
>> # CONFIG_I2C_DEBUG_CORE is not set
>> # CONFIG_I2C_DEBUG_ALGO is not set
>> # CONFIG_I2C_DEBUG_BUS is not set
>> # CONFIG_SPI is not set
>>
>> #
>> # PPS support
>> #
>> # CONFIG_PPS is not set
>> CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
>> # CONFIG_GPIOLIB is not set
>> CONFIG_W1=3Dm
>> CONFIG_W1_CON=3Dy
>>
>> #
>> # 1-wire Bus Masters
>> #
>> # CONFIG_W1_MASTER_MATROX is not set
>> CONFIG_W1_MASTER_DS2490=3Dm
>> CONFIG_W1_MASTER_DS2482=3Dm
>>
>> #
>> # 1-wire Slaves
>> #
>> CONFIG_W1_SLAVE_THERM=3Dm
>> CONFIG_W1_SLAVE_SMEM=3Dm
>> CONFIG_W1_SLAVE_DS2431=3Dm
>> CONFIG_W1_SLAVE_DS2433=3Dm
>> CONFIG_W1_SLAVE_DS2433_CRC=3Dy
>> CONFIG_W1_SLAVE_DS2760=3Dm
>> CONFIG_W1_SLAVE_BQ27000=3Dm
>> CONFIG_POWER_SUPPLY=3Dy
>> # CONFIG_POWER_SUPPLY_DEBUG is not set
>> # CONFIG_PDA_POWER is not set
>> # CONFIG_BATTERY_DS2760 is not set
>> # CONFIG_BATTERY_DS2782 is not set
>> CONFIG_BATTERY_BQ27x00=3Dm
>> # CONFIG_BATTERY_MAX17040 is not set
>> CONFIG_HWMON=3Dm
>> CONFIG_HWMON_VID=3Dm
>> # CONFIG_HWMON_DEBUG_CHIP is not set
>>
>> #
>> # Native drivers
>> #
>> CONFIG_SENSORS_ABITUGURU=3Dm
>> CONFIG_SENSORS_ABITUGURU3=3Dm
>> CONFIG_SENSORS_AD7414=3Dm
>> CONFIG_SENSORS_AD7418=3Dm
>> CONFIG_SENSORS_ADM1021=3Dm
>> CONFIG_SENSORS_ADM1025=3Dm
>> CONFIG_SENSORS_ADM1026=3Dm
>> CONFIG_SENSORS_ADM1029=3Dm
>> CONFIG_SENSORS_ADM1031=3Dm
>> CONFIG_SENSORS_ADM9240=3Dm
>> # CONFIG_SENSORS_ADT7411 is not set
>> CONFIG_SENSORS_ADT7462=3Dm
>> CONFIG_SENSORS_ADT7470=3Dm
>> CONFIG_SENSORS_ADT7475=3Dm
>> # CONFIG_SENSORS_ASC7621 is not set
>> CONFIG_SENSORS_K8TEMP=3Dm
>> # CONFIG_SENSORS_K10TEMP is not set
>> CONFIG_SENSORS_ASB100=3Dm
>> CONFIG_SENSORS_ATXP1=3Dm
>> CONFIG_SENSORS_DS1621=3Dm
>> CONFIG_SENSORS_I5K_AMB=3Dm
>> CONFIG_SENSORS_F71805F=3Dm
>> CONFIG_SENSORS_F71882FG=3Dm
>> CONFIG_SENSORS_F75375S=3Dm
>> CONFIG_SENSORS_FSCHMD=3Dm
>> # CONFIG_SENSORS_G760A is not set
>> CONFIG_SENSORS_GL518SM=3Dm
>> CONFIG_SENSORS_GL520SM=3Dm
>> CONFIG_SENSORS_CORETEMP=3Dm
>> CONFIG_SENSORS_IBMAEM=3Dm
>> CONFIG_SENSORS_IBMPEX=3Dm
>> CONFIG_SENSORS_IT87=3Dm
>> CONFIG_SENSORS_LM63=3Dm
>> # CONFIG_SENSORS_LM73 is not set
>> CONFIG_SENSORS_LM75=3Dm
>> CONFIG_SENSORS_LM77=3Dm
>> CONFIG_SENSORS_LM78=3Dm
>> CONFIG_SENSORS_LM80=3Dm
>> CONFIG_SENSORS_LM83=3Dm
>> CONFIG_SENSORS_LM85=3Dm
>> CONFIG_SENSORS_LM87=3Dm
>> CONFIG_SENSORS_LM90=3Dm
>> CONFIG_SENSORS_LM92=3Dm
>> CONFIG_SENSORS_LM93=3Dm
>> # CONFIG_SENSORS_LTC4215 is not set
>> CONFIG_SENSORS_LTC4245=3Dm
>> # CONFIG_SENSORS_LM95241 is not set
>> CONFIG_SENSORS_MAX1619=3Dm
>> CONFIG_SENSORS_MAX6650=3Dm
>> CONFIG_SENSORS_PC87360=3Dm
>> CONFIG_SENSORS_PC87427=3Dm
>> CONFIG_SENSORS_PCF8591=3Dm
>> CONFIG_SENSORS_SIS5595=3Dm<
>
> ...
>
> [=D3=CA=BC=FE=B2=BF=B7=D6=D2=FE=B2=D8]




--=20
Best wishes
(CN:=BB=C6=D0=F1,Huang xu)--------(EN:alamo)
@Class Three Major in Embeded System@domain.hid USTC,
166, Ren-ai Road, Suzhou, Jiangsu, P.R. China
215123
MAIL:lovealamo (AT) gmail.com
TEL:18915412309

--20cf305b0e027f32dc049ee81177
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div>I use all the cpu (0---7) in my application. </div>
<div>&nbsp;</div>
<div>just like below.</div>
<div>&nbsp;</div>
<div>rt_task_create(......,T_CPU(0));//the stack is 1M(1024*1024)</div>
<div>&nbsp;</div>
<div>rt_task_create(......,T_CPU(1));//the stack is 64M(1024*1024*64)<br></=
div>
<div>rt_task_create(......,T_CPU(2));//the stack is 64M(1024*1024*64)</div>
<div>&nbsp;</div>
<div>rt_task_create(......,T_CPU(3));//the stakc is 1M</div>
<div>&nbsp;</div>
<div>rt_task_create(......,T_CPU(4));//the stack is 1M</div>
<div>&nbsp;</div>
<div>rt_task_create(......,T_CPU(5));//the stack is 1M</div>
<div>&nbsp;</div>
<div>rt_task_create(......,T_CPU(6));//the stack is 1M</div>
<div>&nbsp;</div>
<div>rt_task_create(......,T_CPU(7));//the stack is 1M</div>
<div>&nbsp;</div>
<div>please help me checking which the problem is!</div>
<div>&nbsp;</div>
<div>thanks.</div>
<div>&nbsp;</div>
<div><br>&nbsp;</div>
<div class=3D"gmail_quote">=D4=DA 2011=C4=EA3=D4=C220=C8=D5 =CF=C2=CE=E77:0=
4=A3=ACalamo hwuang <span dir=3D"ltr">&lt;<a href=3D"mailto:lovealamo@domain.hid=
.com">lovealamo@domain.hid</a>&gt;</span>=D0=B4=B5=C0=A3=BA<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div>The crash down infomation of strace tool is below</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>strace ./APP_LTE_DEMO ../config.txt<br>execve(&quot;./APP_LTE_DEMO&quo=
t;, [&quot;./APP_LTE_DEMO&quot;, &quot;../config.txt&quot;], [/* 92 vars */=
]) =3D 0<br>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x15=
9e4000<br>mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,=
 -1, 0) =3D 0x7fe970d4b000<br>
access(&quot;/etc/ld.so.preload&quot;, R_OK)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/intel/Compiler=
/11.1/072/lib/intel64/tls/x86_64/libstdc++.so.6&quot;, O_RDONLY) =3D -1 ENO=
ENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/lib/intel64/tls/x86_64&quot;, 0x7ff=
fdbbfe0a0) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/int=
el/Compiler/11.1/072/lib/intel64/tls/libstdc++.so.6&quot;, O_RDONLY) =3D -1=
 ENOENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/lib/intel64/tls&quot;, 0x7fffdbbfe0=
a0) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/intel/Comp=
iler/11.1/072/lib/intel64/x86_64/libstdc++.so.6&quot;, O_RDONLY) =3D -1 ENO=
ENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/lib/intel64/x86_64&quot;, 0x7fffdbb=
fe0a0) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/intel/C=
ompiler/11.1/072/lib/intel64/libstdc++.so.6&quot;, O_RDONLY) =3D -1 ENOENT =
(No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/lib/intel64&quot;, {st_mode=3DS_IFD=
IR|0755, st_size=3D4096, ...}) =3D 0<br>open(&quot;/opt/intel/Compiler/11.1=
/072/ipp/em64t/sharedlib/tls/x86_64/libstdc++.so.6&quot;, O_RDONLY) =3D -1 =
ENOENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/tls/x86_64&quot=
;, 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)<br>open(&quot;=
/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/tls/libstdc++.so.6&quot;, =
O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/tls&quot;, 0x7f=
ffdbbfe0a0) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/in=
tel/Compiler/11.1/072/ipp/em64t/sharedlib/x86_64/libstdc++.so.6&quot;, O_RD=
ONLY) =3D -1 ENOENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/x86_64&quot;, 0=
x7fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt=
/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libstdc++.so.6&quot;, O_RDONLY=
) =3D -1 ENOENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib&quot;, {st_mode=
=3DS_IFDIR|0755, st_size=3D12288, ...}) =3D 0<br>open(&quot;/opt/intel/Comp=
iler/11.1/072/mkl/lib/em64t/tls/x86_64/libstdc++.so.6&quot;, O_RDONLY) =3D =
-1 ENOENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/mkl/lib/em64t/tls/x86_64&quot;, 0x7=
fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/i=
ntel/Compiler/11.1/072/mkl/lib/em64t/tls/libstdc++.so.6&quot;, O_RDONLY) =
=3D -1 ENOENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/mkl/lib/em64t/tls&quot;, 0x7fffdbbf=
e0a0) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/intel/Co=
mpiler/11.1/072/mkl/lib/em64t/x86_64/libstdc++.so.6&quot;, O_RDONLY) =3D -1=
 ENOENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/mkl/lib/em64t/x86_64&quot;, 0x7fffd=
bbfe0a0) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/intel=
/Compiler/11.1/072/mkl/lib/em64t/libstdc++.so.6&quot;, O_RDONLY) =3D -1 ENO=
ENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/mkl/lib/em64t&quot;, {st_mode=3DS_I=
FDIR|0755, st_size=3D4096, ...}) =3D 0<br>open(&quot;/opt/intel/Compiler/11=
.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.16.21/lib/tls/x86_64/libstdc++=
.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2=
.6.16.21/lib/tls/x86_64&quot;, 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file =
or directory)<br>open(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.=
0_libc2.4_kernel2.6.16.21/lib/tls/libstdc++.so.6&quot;, O_RDONLY) =3D -1 EN=
OENT (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2=
.6.16.21/lib/tls&quot;, 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or dire=
ctory)<br>open(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2=
.4_kernel2.6.16.21/lib/x86_64/libstdc++.so.6&quot;, O_RDONLY) =3D -1 ENOENT=
 (No such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2=
.6.16.21/lib/x86_64&quot;, 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or d=
irectory)<br>open(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_li=
bc2.4_kernel2.6.16.21/lib/libstdc++.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No=
 such file or directory)<br>
stat(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2=
.6.16.21/lib&quot;, {st_mode=3DS_IFDIR|0755, st_size=3D4096, ...}) =3D 0<br=
>open(&quot;/usr/xenomai/lib/tls/x86_64/libstdc++.so.6&quot;, O_RDONLY) =3D=
 -1 ENOENT (No such file or directory)<br>
stat(&quot;/usr/xenomai/lib/tls/x86_64&quot;, 0x7fffdbbfe0a0) =3D -1 ENOENT=
 (No such file or directory)<br>open(&quot;/usr/xenomai/lib/tls/libstdc++.s=
o.6&quot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>stat(&quo=
t;/usr/xenomai/lib/tls&quot;, 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file o=
r directory)<br>
open(&quot;/usr/xenomai/lib/x86_64/libstdc++.so.6&quot;, O_RDONLY) =3D -1 E=
NOENT (No such file or directory)<br>stat(&quot;/usr/xenomai/lib/x86_64&quo=
t;, 0x7fffdbbfe0a0) =3D -1 ENOENT (No such file or directory)<br>open(&quot=
;/usr/xenomai/lib/libstdc++.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No such fi=
le or directory)<br>
stat(&quot;/usr/xenomai/lib&quot;, {st_mode=3DS_IFDIR|0755, st_size=3D4096,=
 ...}) =3D 0<br>open(&quot;tls/x86_64/libstdc++.so.6&quot;, O_RDONLY) =3D -=
1 ENOENT (No such file or directory)<br>open(&quot;tls/libstdc++.so.6&quot;=
, O_RDONLY)&nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file or directory)<br>
open(&quot;x86_64/libstdc++.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No such fi=
le or directory)<br>open(&quot;libstdc++.so.6&quot;, O_RDONLY)&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file or directory)<br>=
open(&quot;/usr/xenomai/lib/libstdc++.so.6&quot;, O_RDONLY) =3D -1 ENOENT (=
No such file or directory)<br>
open(&quot;/etc/ld.so.cache&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 3<br>fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D228027, ...}) =3D 0<br=
>mmap(NULL, 228027, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7fe970d13000<br>clo=
se(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>
open(&quot;/usr/lib64/libstdc++.so.6&quot;, O_RDONLY) =3D 3<br>read(3, &quo=
t;\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0\360k\5\0\0\0\0\0&quot;.=
.., 832) =3D 832<br>fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1015448, ..=
.}) =3D 0<br>
mmap(NULL, 3187512, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0x7fe970823000<br>fadvise64(3, 0, 3187512, POSIX_FADV_WILLNEED) =3D 0<b=
r>mprotect(0x7fe970913000, 2093056, PROT_NONE) =3D 0<br>mmap(0x7fe970b12000=
, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xef=
000) =3D 0x7fe970b12000<br>
mmap(0x7fe970b1b000, 74552, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x7fe970b1b000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D 0<br>open(&quot;/opt/intel/Compiler/11.1/072/lib/intel64/lib=
xenomai.so.0&quot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libxenomai.so.0=
&quot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/=
opt/intel/Compiler/11.1/072/mkl/lib/em64t/libxenomai.so.0&quot;, O_RDONLY) =
=3D -1 ENOENT (No such file or directory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2=
.6.16.21/lib/libxenomai.so.0&quot;, O_RDONLY) =3D -1 ENOENT (No such file o=
r directory)<br>open(&quot;/usr/xenomai/lib/libxenomai.so.0&quot;, O_RDONLY=
) =3D 3<br>
read(3, &quot;\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0\20\26\0\0\0=
\0\0\0&quot;..., 832) =3D 832<br>fstat(3, {st_mode=3DS_IFREG|0755, st_size=
=3D26455, ...}) =3D 0<br>mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE=
|MAP_ANONYMOUS, -1, 0) =3D 0x7fe970d12000<br>
mmap(NULL, 2114808, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0x7fe97061e000<br>fadvise64(3, 0, 2114808, POSIX_FADV_WILLNEED) =3D 0<b=
r>mprotect(0x7fe970621000, 2097152, PROT_NONE) =3D 0<br>mmap(0x7fe970821000=
, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x300=
0) =3D 0x7fe970821000<br>
close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>open(&quot;/opt/intel=
/Compiler/11.1/072/lib/intel64/libpthread.so.0&quot;, O_RDONLY) =3D -1 ENOE=
NT (No such file or directory)<br>open(&quot;/opt/intel/Compiler/11.1/072/i=
pp/em64t/sharedlib/libpthread.so.0&quot;, O_RDONLY) =3D -1 ENOENT (No such =
file or directory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libpthread.so.0&quot;=
, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/in=
tel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.16.21/lib/libpt=
hread.so.0&quot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
open(&quot;/usr/xenomai/lib/libpthread.so.0&quot;, O_RDONLY) =3D -1 ENOENT =
(No such file or directory)<br>open(&quot;tls/x86_64/libpthread.so.0&quot;,=
 O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>open(&quot;tls/libp=
thread.so.0&quot;, O_RDONLY)&nbsp;&nbsp; =3D -1 ENOENT (No such file or dir=
ectory)<br>
open(&quot;x86_64/libpthread.so.0&quot;, O_RDONLY) =3D -1 ENOENT (No such f=
ile or directory)<br>open(&quot;libpthread.so.0&quot;, O_RDONLY)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file or directory)<br>open=
(&quot;/usr/xenomai/lib/libpthread.so.0&quot;, O_RDONLY) =3D -1 ENOENT (No =
such file or directory)<br>
open(&quot;/lib64/libpthread.so.0&quot;, O_RDONLY) =3D 3<br>read(3, &quot;\=
177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0@domain.hid&quot;..., 83=
2) =3D 832<br>fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D135646, ...}) =3D=
 0<br>
mmap(NULL, 2212736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0x7fe970401000<br>fadvise64(3, 0, 2212736, POSIX_FADV_WILLNEED) =3D 0<b=
r>mprotect(0x7fe970418000, 2097152, PROT_NONE) =3D 0<br>mmap(0x7fe970618000=
, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x170=
00) =3D 0x7fe970618000<br>
mmap(0x7fe97061a000, 13184, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x7fe97061a000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D 0<br>open(&quot;/opt/intel/Compiler/11.1/072/lib/intel64/lib=
native.so.3&quot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libnative.so.3&=
quot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/o=
pt/intel/Compiler/11.1/072/mkl/lib/em64t/libnative.so.3&quot;, O_RDONLY) =
=3D -1 ENOENT (No such file or directory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2=
.6.16.21/lib/libnative.so.3&quot;, O_RDONLY) =3D -1 ENOENT (No such file or=
 directory)<br>open(&quot;/usr/xenomai/lib/libnative.so.3&quot;, O_RDONLY) =
=3D 3<br>
read(3, &quot;\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0\2201\0\0\0\=
0\0\0&quot;..., 832) =3D 832<br>fstat(3, {st_mode=3DS_IFREG|0755, st_size=
=3D53279, ...}) =3D 0<br>mmap(NULL, 2138512, PROT_READ|PROT_EXEC, MAP_PRIVA=
TE|MAP_DENYWRITE, 3, 0) =3D 0x7fe9701f6000<br>
fadvise64(3, 0, 2138512, POSIX_FADV_WILLNEED) =3D 0<br>mprotect(0x7fe970200=
000, 2093056, PROT_NONE) =3D 0<br>mmap(0x7fe9703ff000, 8192, PROT_READ|PROT=
_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9000) =3D 0x7fe9703ff000<=
br>
close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>open(&quot;/opt/intel=
/Compiler/11.1/072/lib/intel64/libm.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No=
 such file or directory)<br>open(&quot;/opt/intel/Compiler/11.1/072/ipp/em6=
4t/sharedlib/libm.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No such file or dire=
ctory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libm.so.6&quot;, O_RD=
ONLY) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/intel/Co=
mpiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.16.21/lib/libm.so.6&q=
uot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
open(&quot;/usr/xenomai/lib/libm.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No su=
ch file or directory)<br>open(&quot;tls/x86_64/libm.so.6&quot;, O_RDONLY)&n=
bsp; =3D -1 ENOENT (No such file or directory)<br>open(&quot;tls/libm.so.6&=
quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENO=
ENT (No such file or directory)<br>
open(&quot;x86_64/libm.so.6&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D -1 ENOENT (No such file or directory)<br>open(&quot;libm.so.6&quot;, O_=
RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D -1 ENOENT (No such file or directory)<br>open(&quot;/usr/xenomai/l=
ib/libm.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
open(&quot;/lib64/libm.so.6&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 3<br>read(3, &quot;\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0`&g=
t;\0\0\0\0\0\0&quot;..., 832) =3D 832<br>fstat(3, {st_mode=3DS_IFREG|0755, =
st_size=3D388274, ...}) =3D 0<br>
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7fe970d11000<br>mmap(NULL, 2445496, PROT_READ|PROT_EXEC, MAP_PRIVATE|=
MAP_DENYWRITE, 3, 0) =3D 0x7fe96ffa0000<br>fadvise64(3, 0, 2445496, POSIX_F=
ADV_WILLNEED) =3D 0<br>
mprotect(0x7fe96fff5000, 2093056, PROT_NONE) =3D 0<br>mmap(0x7fe9701f4000, =
8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x54000=
) =3D 0x7fe9701f4000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<=
br>open(&quot;/opt/intel/Compiler/11.1/072/lib/intel64/libgcc_s.so.1&quot;,=
 O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libgcc_s.so.1&q=
uot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/op=
t/intel/Compiler/11.1/072/mkl/lib/em64t/libgcc_s.so.1&quot;, O_RDONLY) =3D =
-1 ENOENT (No such file or directory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2=
.6.16.21/lib/libgcc_s.so.1&quot;, O_RDONLY) =3D -1 ENOENT (No such file or =
directory)<br>open(&quot;/usr/xenomai/lib/libgcc_s.so.1&quot;, O_RDONLY) =
=3D -1 ENOENT (No such file or directory)<br>
open(&quot;tls/x86_64/libgcc_s.so.1&quot;, O_RDONLY) =3D -1 ENOENT (No such=
 file or directory)<br>open(&quot;tls/libgcc_s.so.1&quot;, O_RDONLY)&nbsp;&=
nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file or directory)<br>open(&quot;x=
86_64/libgcc_s.so.1&quot;, O_RDONLY)&nbsp; =3D -1 ENOENT (No such file or d=
irectory)<br>
open(&quot;libgcc_s.so.1&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D -1 ENOENT (No such file or directory)<br>open(&quot;/usr=
/xenomai/lib/libgcc_s.so.1&quot;, O_RDONLY) =3D -1 ENOENT (No such file or =
directory)<br>open(&quot;/lib64/libgcc_s.so.1&quot;, O_RDONLY)&nbsp; =3D 3<=
br>
read(3, &quot;\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0\300,\0\0\0\=
0\0\0&quot;..., 832) =3D 832<br>fstat(3, {st_mode=3DS_IFREG|0755, st_size=
=3D92648, ...}) =3D 0<br>mmap(NULL, 2188280, PROT_READ|PROT_EXEC, MAP_PRIVA=
TE|MAP_DENYWRITE, 3, 0) =3D 0x7fe96fd89000<br>
fadvise64(3, 0, 2188280, POSIX_FADV_WILLNEED) =3D 0<br>mprotect(0x7fe96fd9f=
000, 2093056, PROT_NONE) =3D 0<br>mmap(0x7fe96ff9e000, 8192, PROT_READ|PROT=
_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15000) =3D 0x7fe96ff9e000=
<br>
close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>open(&quot;/opt/intel=
/Compiler/11.1/072/lib/intel64/libc.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No=
 such file or directory)<br>open(&quot;/opt/intel/Compiler/11.1/072/ipp/em6=
4t/sharedlib/libc.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No such file or dire=
ctory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/mkl/lib/em64t/libc.so.6&quot;, O_RD=
ONLY) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/intel/Co=
mpiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2.6.16.21/lib/libc.so.6&q=
uot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
open(&quot;/usr/xenomai/lib/libc.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No su=
ch file or directory)<br>open(&quot;tls/x86_64/libc.so.6&quot;, O_RDONLY)&n=
bsp; =3D -1 ENOENT (No such file or directory)<br>open(&quot;tls/libc.so.6&=
quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENO=
ENT (No such file or directory)<br>
open(&quot;x86_64/libc.so.6&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D -1 ENOENT (No such file or directory)<br>open(&quot;libc.so.6&quot;, O_=
RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D -1 ENOENT (No such file or directory)<br>open(&quot;/usr/xenomai/l=
ib/libc.so.6&quot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
open(&quot;/lib64/libc.so.6&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 3<br>read(3, &quot;\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0\34=
0\354\1\0\0\0\0\0&quot;..., 832) =3D 832<br>fstat(3, {st_mode=3DS_IFREG|075=
5, st_size=3D1661454, ...}) =3D 0<br>
mmap(NULL, 3528776, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0x7fe96fa2b000<br>fadvise64(3, 0, 3528776, POSIX_FADV_WILLNEED) =3D 0<b=
r>mprotect(0x7fe96fb7f000, 2097152, PROT_NONE) =3D 0<br>mmap(0x7fe96fd7f000=
, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15=
4000) =3D 0x7fe96fd7f000<br>
mmap(0x7fe96fd84000, 18504, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x7fe96fd84000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D 0<br>open(&quot;/opt/intel/Compiler/11.1/072/lib/intel64/lib=
dl.so.2&quot;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/ipp/em64t/sharedlib/libdl.so.2&quot=
;, O_RDONLY) =3D -1 ENOENT (No such file or directory)<br>open(&quot;/opt/i=
ntel/Compiler/11.1/072/mkl/lib/em64t/libdl.so.2&quot;, O_RDONLY) =3D -1 ENO=
ENT (No such file or directory)<br>
open(&quot;/opt/intel/Compiler/11.1/072/tbb/intel64/cc4.1.0_libc2.4_kernel2=
.6.16.21/lib/libdl.so.2&quot;, O_RDONLY) =3D -1 ENOENT (No such file or dir=
ectory)<br>open(&quot;/usr/xenomai/lib/libdl.so.2&quot;, O_RDONLY) =3D -1 E=
NOENT (No such file or directory)<br>
open(&quot;tls/x86_64/libdl.so.2&quot;, O_RDONLY) =3D -1 ENOENT (No such fi=
le or directory)<br>open(&quot;tls/libdl.so.2&quot;, O_RDONLY)&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file or directory)<br>=
open(&quot;x86_64/libdl.so.2&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp; =3D -=
1 ENOENT (No such file or directory)<br>
open(&quot;libdl.so.2&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file or directory)<br>=
open(&quot;/usr/xenomai/lib/libdl.so.2&quot;, O_RDONLY) =3D -1 ENOENT (No s=
uch file or directory)<br>open(&quot;/lib64/libdl.so.2&quot;, O_RDONLY)&nbs=
p;&nbsp;&nbsp;&nbsp; =3D 3<br>
read(3, &quot;\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0\360\r\0\0\0=
\0\0\0&quot;..., 832) =3D 832<br>fstat(3, {st_mode=3DS_IFREG|0755, st_size=
=3D19114, ...}) =3D 0<br>mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE=
|MAP_ANONYMOUS, -1, 0) =3D 0x7fe970d10000<br>
mmap(NULL, 2109696, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0x7fe96f827000<br>fadvise64(3, 0, 2109696, POSIX_FADV_WILLNEED) =3D 0<b=
r>mprotect(0x7fe96f829000, 2097152, PROT_NONE) =3D 0<br>mmap(0x7fe96fa29000=
, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x200=
0) =3D 0x7fe96fa29000<br>
close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>mmap(NULL, 4096, PROT=
_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fe970d0f000<br>m=
map(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D=
 0x7fe970d0d000<br>
arch_prctl(ARCH_SET_FS, 0x7fe970d0d720) =3D 0<br>mprotect(0x7fe96fa29000, 4=
096, PROT_READ) =3D 0<br>mprotect(0x7fe96fd7f000, 16384, PROT_READ) =3D 0<b=
r>mprotect(0x7fe96ff9e000, 4096, PROT_READ) =3D 0<br>mprotect(0x7fe9701f400=
0, 4096, PROT_READ) =3D 0<br>
mprotect(0x7fe9703ff000, 4096, PROT_READ) =3D 0<br>mprotect(0x7fe970618000,=
 4096, PROT_READ) =3D 0<br>mprotect(0x7fe970821000, 4096, PROT_READ) =3D 0<=
br>mprotect(0x7fe970b12000, 28672, PROT_READ) =3D 0<br>mprotect(0x72e000, 4=
096, PROT_READ)&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>
mprotect(0x7fe970d4c000, 4096, PROT_READ) =3D 0<br>munmap(0x7fe970d13000, 2=
28027)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>set_t=
id_address(0x7fe970d0d9f0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 7836<br>set_robust_list(0x7fe970d0da00, 0x18)&nbsp;&nbsp; =3D 0<br>fute=
x(0x7fffdbbfe96c, FUTEX_WAKE_PRIVATE, 1) =3D 0<br>
futex(0x7fffdbbfe96c, 0x189 /* FUTEX_??? */, 1, NULL, 7fe970d0d720) =3D -1 =
EAGAIN (Resource temporarily unavailable)<br>rt_sigaction(SIGRTMIN, {0x7fe9=
704068b0, [], SA_RESTORER|SA_SIGINFO, 0x7fe9704105d0}, NULL, 8) =3D 0<br>rt=
_sigaction(SIGRT_1, {0x7fe970406940, [], SA_RESTORER|SA_RESTART|SA_SIGINFO,=
 0x7fe9704105d0}, NULL, 8) =3D 0<br>
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) =3D 0<br>getrlimit(RLIMI=
T_STACK, {rlim_cur=3D8192*1024, rlim_max=3DRLIM_INFINITY}) =3D 0<br>access(=
&quot;/dev/rtheap&quot;, F_OK)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>rt_sigaction(SIGILL, {0x7fe97061f7b0, =
[ILL], SA_RESTORER|SA_RESTART, 0x7fe96fa5d9e0}, {SIG_DFL, [], 0}, 8) =3D 0<=
br>
rt_sigaction(SIGILL, {SIG_DFL, [ILL], SA_RESTORER|SA_RESTART, 0x7fe96fa5d9e=
0}, {0x7fe97061f7b0, [ILL], SA_RESTORER|SA_RESTART, 0x7fe96fa5d9e0}, 8) =3D=
 0<br>open(&quot;/dev/rtheap&quot;, O_RDWR)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3<br>ioctl(3, 0, 0xffff8800dc5=
e5428)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =3D 0x7fe970d4700=
0<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>futex(0x7fe97082=
23a0, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0<br>open(&quot;/dev/rtheap&quot;=
, O_RDWR)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; =3D 3<br>
ioctl(3, 0, 0xffffffff81b28838)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 0<br>mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =3D=
 0x7fe970d44000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>fu=
tex(0x7fe9708223a4, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0<br>
futex(0x7fe970822260, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0<br>futex(0x7fe9=
70822340, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0<br>rt_sigaction(SIGXCPU, {0=
x7fe97061f7e0, [], SA_RESTORER|SA_SIGINFO, 0x7fe9704105d0}, NULL, 8) =3D 0<=
br>
brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x159e4000<br>br=
k(0x15a05000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D 0x15a05000<br>open(&quot;../config.txt&quot;, O_RDONLY)&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3<br>fstat(3, {st_mode=3DS_IFR=
EG|0755, st_size=3D125, ...}) =3D 0<br>
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7fe970d43000<br>read(3, &quot;eth0 C8:0A:A9:11:A7:DF\r\neth1 00:&quot=
;..., 4096) =3D 125<br>open(&quot;/root/stats/stats.xml&quot;, O_RDWR|O_CRE=
AT|O_APPEND, 0666) =3D -1 ENOENT (No such file or directory)<br>
open(&quot;/root/stats/ctrl.txt&quot;, O_RDWR|O_CREAT|O_TRUNC, 0666) =3D -1=
 ENOENT (No such file or directory)<br>read(3, &quot;&quot;, 4096)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>close(3)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>munmap(0x7fe970d43000, 4096)&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>
socket(PF_PACKET, SOCK_RAW, 8)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =3D 3<br>socket(PF_PACKET, SOCK_RAW, 768)&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D 4<br>ioctl(3, SIOCGIFINDEX, {ifr_name=3D&quot;eth0&q=
uot;, ifr_index=3D2}) =3D 0<br>bind(3, {sa_family=3DAF_PACKET, proto=3D0x80=
0, if2, pkttype=3DPACKET_HOST, addr(0)=3D{0, }, 20) =3D 0<br>
ioctl(3, SIOCGIFFLAGS, {ifr_name=3D&quot;eth0&quot;, ifr_flags=3DIFF_UP|IFF=
_BROADCAST|IFF_RUNNING|IFF_PROMISC|IFF_MULTICAST}) =3D 0<br>ioctl(3, SIOCSI=
FFLAGS, 0x7fffdbbfe740)&nbsp; =3D 0<br>ioctl(3, SIOCGIFINDEX, {ifr_name=3D&=
quot;eth0&quot;, ifr_index=3D2}) =3D 0<br>
ioctl(4, SIOCGIFINDEX, {ifr_name=3D&quot;eth1&quot;, ifr_index=3D3}) =3D 0<=
br>mmap(NULL, 491524096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -=
1, 0) =3D 0x7fe952366000<br>fstat(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmak=
edev(136, 1), ...}) =3D 0<br>
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7fe970d43000<br>write(1, &quot;Noise Generated\n&quot;, 16Noise Gener=
ated<br>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 16<br>mlockall(MCL_CURREN=
T|MCL_FUTURE)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<br>sched_get_=
priority_min(SCHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 1<br>
sched_get_priority_max(SCHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 99<br>=
mmap(NULL, 1052672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STA=
CK, -1, 0) =3D 0x7fe970c0c000<br>mprotect(0x7fe970c0c000, 4096, PROT_NONE) =
=3D 0<br>sched_get_priority_min(SCHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 1<br>
sched_get_priority_max(SCHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 99<br>=
clone(child_stack=3D0x7fe970d0bfd0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|C=
LONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CL=
ONE_CHILD_CLEARTID, parent_tidptr=3D0x7fe970d0c9e0, tls=3D0x7fe970d0c710, c=
hild_tidptr=3D0x7fe970d0c9e0) =3D 7837<br>
sched_setscheduler(7837, SCHED_FIFO, { 22 }) =3D 0<br>futex(0x7fe970d0cd28,=
 FUTEX_WAKE_PRIVATE, 1) =3D 1<br>sched_get_priority_min(SCHED_FIFO)&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SCHED_FIFO)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 99<br>mmap(NULL, 1052672, PROT_READ|PROT_WRITE, M=
AP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe952265000<br>
mprotect(0x7fe952265000, 4096, PROT_NONE) =3D 0<br>sched_get_priority_min(S=
CHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SC=
HED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 99<br>clone(child_stack=3D0x7fe=
952364fd0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD=
|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, paren=
t_tidptr=3D0x7fe9523659e0, tls=3D0x7fe952365710, child_tidptr=3D0x7fe952365=
9e0) =3D 7838<br>
sched_setscheduler(7838, SCHED_FIFO, { 23 }) =3D 0<br>futex(0x7fe952365d28,=
 FUTEX_WAKE_PRIVATE, 1) =3D 1<br>sched_get_priority_min(SCHED_FIFO)&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SCHED_FIFO)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 99<br>mmap(NULL, 1052672, PROT_READ|PROT_WRITE, M=
AP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe952164000<br>
mprotect(0x7fe952164000, 4096, PROT_NONE) =3D 0<br>sched_get_priority_min(S=
CHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SC=
HED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 99<br>clone(child_stack=3D0x7fe=
952263fd0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD=
|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, paren=
t_tidptr=3D0x7fe9522649e0, tls=3D0x7fe952264710, child_tidptr=3D0x7fe952264=
9e0) =3D 7839<br>
sched_setscheduler(7839, SCHED_FIFO, { 20 }) =3D 0<br>futex(0x7fe952264d28,=
 FUTEX_WAKE_PRIVATE, 1) =3D 1<br>sched_get_priority_min(SCHED_FIFO)&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SCHED_FIFO)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 99<br>mmap(NULL, 1052672, PROT_READ|PROT_WRITE, M=
AP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe952063000<br>
mprotect(0x7fe952063000, 4096, PROT_NONE) =3D 0<br>sched_get_priority_min(S=
CHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SC=
HED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 99<br>clone(child_stack=3D0x7fe=
952162fd0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD=
|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, paren=
t_tidptr=3D0x7fe9521639e0, tls=3D0x7fe952163710, child_tidptr=3D0x7fe952163=
9e0) =3D 7840<br>
sched_setscheduler(7840, SCHED_FIFO, { 21 }) =3D 0<br>futex(0x7fe952163d28,=
 FUTEX_WAKE_PRIVATE, 1) =3D 1<br>sched_get_priority_min(SCHED_FIFO)&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SCHED_FIFO)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 99<br>mmap(NULL, 1052672, PROT_READ|PROT_WRITE, M=
AP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe951f62000<br>
mprotect(0x7fe951f62000, 4096, PROT_NONE) =3D 0<br>sched_get_priority_min(S=
CHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SC=
HED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 99<br>clone(child_stack=3D0x7fe=
952061fd0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD=
|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, paren=
t_tidptr=3D0x7fe9520629e0, tls=3D0x7fe952062710, child_tidptr=3D0x7fe952062=
9e0) =3D 7841<br>
sched_setscheduler(7841, SCHED_FIFO, { 30 }) =3D 0<br>futex(0x7fe952062d28,=
 FUTEX_WAKE_PRIVATE, 1) =3D 1<br>sched_get_priority_min(SCHED_FIFO)&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SCHED_FIFO)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 99<br>mmap(NULL, 67112960, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe94df61000<br>
mprotect(0x7fe94df61000, 4096, PROT_NONE) =3D 0<br>sched_get_priority_min(S=
CHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SC=
HED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 99<br>clone(child_stack=3D0x7fe=
951f60fd0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD=
|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, paren=
t_tidptr=3D0x7fe951f619e0, tls=3D0x7fe951f61710, child_tidptr=3D0x7fe951f61=
9e0) =3D 7842<br>
sched_setscheduler(7842, SCHED_FIFO, { 31 }) =3D 0<br>futex(0x7fe951f61d28,=
 FUTEX_WAKE_PRIVATE, 1) =3D 1<br>sched_get_priority_min(SCHED_FIFO)&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SCHED_FIFO)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 99<br>mmap(NULL, 69632, PROT_READ|PROT_WRITE, MAP=
_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe970d32000<br>
mprotect(0x7fe970d32000, 4096, PROT_NONE) =3D 0<br>sched_get_priority_min(S=
CHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SC=
HED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 99<br>clone(child_stack=3D0x7fe=
970d41fd0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD=
|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, paren=
t_tidptr=3D0x7fe970d429e0, tls=3D0x7fe970d42710, child_tidptr=3D0x7fe970d42=
9e0) =3D 7843<br>
sched_setscheduler(7843, SCHED_FIFO, { 15 }) =3D 0<br>futex(0x7fe970d42d28,=
 FUTEX_WAKE_PRIVATE, 1) =3D 1<br>sched_get_priority_min(SCHED_FIFO)&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SCHED_FIFO)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 99<br>mmap(NULL, 69632, PROT_READ|PROT_WRITE, MAP=
_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fe970d21000<br>
mprotect(0x7fe970d21000, 4096, PROT_NONE) =3D 0<br>sched_get_priority_min(S=
CHED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 1<br>sched_get_priority_max(SC=
HED_FIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 99<br>clone(child_stack=3D0x7fe=
970d30fd0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD=
|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, paren=
t_tidptr=3D0x7fe970d319e0, tls=3D0x7fe970d31710, child_tidptr=3D0x7fe970d31=
9e0) =3D 7844<br>
<font color=3D"#ff0000">sched_setscheduler(7844, SCHED_FIFO, { 10 }) =3D 0<=
br>futex(0x7fe970d31d28, FUTEX_WAKE_PRIVATE, 1) =3D 1<br>futex(0x7fe970d319=
e0, FUTEX_WAIT, 7844, NULL &lt;unfinished ...&gt;<br>+++ killed by SIGSEGV =
+++&nbsp;</font></div>

<div><font color=3D"#ff0000"></font>&nbsp;</div>
<div><font color=3D"#ff0000"></font>&nbsp;</div>
<div><font color=3D"#ff0000"></font>&nbsp;</div>
<div><font color=3D"#ff0000">Can you help me to find the problem? </font></=
div>
<div><font color=3D"#ff0000"></font>&nbsp;</div>
<div><font color=3D"#ff0000"></font>&nbsp;</div>
<div><font color=3D"#ff0000">The problem persists in the (kernel 2.6.34.5 w=
ith xenomai 2.5.4) and (kernel 2.6.34.5 with xenomai 2.5.6) and (kernel 2.6=
.37 with xenomai 2.5.6). the configure file .config are all the same. like =
above file.</font></div>

<div>&nbsp;</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div class=3D"gmail_quote">=D4=DA 2011=C4=EA3=D4=C220=C8=D5 =CF=C2=CE=E76:5=
6=A3=ACalamo hwuang <span dir=3D"ltr">&lt;<a href=3D"mailto:lovealamo@domain.hid=
.com" target=3D"_blank">lovealamo@domain.hid</a>&gt;</span>=D0=B4=B5=C0=A3=
=BA=20
<div>
<div></div>
<div class=3D"h5"><br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">Hi Gilles<br><br>The error of &q=
uot;c:929:error implicit declaration of function<br>&quot;set_cpus_allowed&=
quot;&quot;&nbsp; is handed by me. But I didn&#39;t know the reason. I just=
&nbsp; uncheck the item &quot;enable maximum number of smp processor and nu=
ma nodes&quot; and sign the maximum number of CPU as 8(maximum number of cp=
us). after that it can make and no error.<br>
<br>But there is another huge problems . My application will segmant failt =
every time in the xenomai paltfrom. The detail as below.<br><br>cpu:i7 2600=
 (sandy bridge)<br><br>the linux kernel linux-2.6.34.5 <br>xenomai package:=
xenomai 2.5.4<br>
<br>the config file is :<br><br>#<br># Automatically generated make config:=
 don&#39;t edit<br># Linux kernel version: 2.6.34.5<br># Thu Oct&nbsp; 7 17=
:10:41 2010<br>#<br>CONFIG_64BIT=3Dy<br># CONFIG_X86_32 is not set<br>CONFI=
G_X86_64=3Dy<br>
CONFIG_X86=3Dy<br>CONFIG_OUTPUT_FORMAT=3D&quot;elf64-x86-64&quot;<br>CONFIG=
_ARCH_DEFCONFIG=3D&quot;arch/x86/configs/x86_64_defconfig&quot;<br>CONFIG_G=
ENERIC_TIME=3Dy<br>CONFIG_GENERIC_CMOS_UPDATE=3Dy<br>CONFIG_CLOCKSOURCE_WAT=
CHDOG=3Dy<br>
CONFIG_GENERIC_CLOCKEVENTS=3Dy<br>CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy<=
br>CONFIG_LOCKDEP_SUPPORT=3Dy<br>CONFIG_STACKTRACE_SUPPORT=3Dy<br>CONFIG_HA=
VE_LATENCYTOP_SUPPORT=3Dy<br>CONFIG_MMU=3Dy<br>CONFIG_ZONE_DMA=3Dy<br>CONFI=
G_NEED_DMA_MAP_STATE=3Dy<br>
CONFIG_GENERIC_ISA_DMA=3Dy<br>CONFIG_GENERIC_IOMAP=3Dy<br>CONFIG_GENERIC_BU=
G=3Dy<br>CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy<br>CONFIG_GENERIC_HWEIGHT=
=3Dy<br>CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy<br># CONFIG_RWSEM_GENERIC_SPINLOCK =
is not set<br>
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy<br>CONFIG_ARCH_HAS_CPU_IDLE_WAIT=3Dy<br>=
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy<br>CONFIG_GENERIC_TIME_VSYSCALL=3Dy<br>C=
ONFIG_ARCH_HAS_CPU_RELAX=3Dy<br>CONFIG_ARCH_HAS_DEFAULT_IDLE=3Dy<br>CONFIG_=
ARCH_HAS_CACHE_LINE_SIZE=3Dy<br>
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy<br>CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=
=3Dy<br>CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy<br>CONFIG_HAVE_CPUMASK_OF_=
CPU_MAP=3Dy<br>CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy<br>CONFIG_ARCH_SUSPEND_=
POSSIBLE=3Dy<br>
CONFIG_ZONE_DMA32=3Dy<br>CONFIG_ARCH_POPULATES_NODE_MAP=3Dy<br>CONFIG_AUDIT=
_ARCH=3Dy<br>CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy<br>CONFIG_ARCH_SUP=
PORTS_DEBUG_PAGEALLOC=3Dy<br>CONFIG_HAVE_EARLY_RES=3Dy<br>CONFIG_HAVE_INTEL=
_TXT=3Dy<br>
CONFIG_GENERIC_HARDIRQS=3Dy<br>CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy<br>CO=
NFIG_GENERIC_IRQ_PROBE=3Dy<br>CONFIG_GENERIC_PENDING_IRQ=3Dy<br>CONFIG_USE_=
GENERIC_SMP_HELPERS=3Dy<br>CONFIG_X86_64_SMP=3Dy<br>CONFIG_X86_HT=3Dy<br>CO=
NFIG_X86_TRAMPOLINE=3Dy<br>
# CONFIG_KTIME_SCALAR is not set<br>CONFIG_DEFCONFIG_LIST=3D&quot;/lib/modu=
les/$UNAME_RELEASE/.config&quot;<br>CONFIG_CONSTRUCTORS=3Dy<br><br>#<br># G=
eneral setup<br>#<br>CONFIG_EXPERIMENTAL=3Dy<br>CONFIG_LOCK_KERNEL=3Dy<br>C=
ONFIG_INIT_ENV_ARG_LIMIT=3D32<br>
CONFIG_LOCALVERSION=3D&quot;&quot;<br># CONFIG_LOCALVERSION_AUTO is not set=
<br>CONFIG_HAVE_KERNEL_GZIP=3Dy<br>CONFIG_HAVE_KERNEL_BZIP2=3Dy<br>CONFIG_H=
AVE_KERNEL_LZMA=3Dy<br>CONFIG_HAVE_KERNEL_LZO=3Dy<br>CONFIG_KERNEL_GZIP=3Dy=
<br># CONFIG_KERNEL_BZIP2 is not set<br>
# CONFIG_KERNEL_LZMA is not set<br># CONFIG_KERNEL_LZO is not set<br>CONFIG=
_SWAP=3Dy<br>CONFIG_SYSVIPC=3Dy<br>CONFIG_SYSVIPC_SYSCTL=3Dy<br>CONFIG_POSI=
X_MQUEUE=3Dy<br>CONFIG_POSIX_MQUEUE_SYSCTL=3Dy<br>CONFIG_BSD_PROCESS_ACCT=
=3Dy<br># CONFIG_BSD_PROCESS_ACCT_V3 is not set<br>
CONFIG_TASKSTATS=3Dy<br>CONFIG_TASK_DELAY_ACCT=3Dy<br>CONFIG_TASK_XACCT=3Dy=
<br>CONFIG_TASK_IO_ACCOUNTING=3Dy<br>CONFIG_AUDIT=3Dy<br>CONFIG_AUDITSYSCAL=
L=3Dy<br>CONFIG_AUDIT_TREE=3Dy<br><br>#<br># RCU Subsystem<br>#<br>CONFIG_T=
REE_RCU=3Dy<br>
# CONFIG_TREE_PREEMPT_RCU is not set<br># CONFIG_TINY_RCU is not set<br># C=
ONFIG_RCU_TRACE is not set<br>CONFIG_RCU_FANOUT=3D64<br># CONFIG_RCU_FANOUT=
_EXACT is not set<br># CONFIG_RCU_FAST_NO_HZ is not set<br># CONFIG_TREE_RC=
U_TRACE is not set<br>
# CONFIG_IKCONFIG is not set<br>CONFIG_LOG_BUF_SHIFT=3D17<br>CONFIG_HAVE_UN=
STABLE_SCHED_CLOCK=3Dy<br>CONFIG_CGROUPS=3Dy<br># CONFIG_CGROUP_DEBUG is no=
t set<br>CONFIG_CGROUP_NS=3Dy<br>CONFIG_CGROUP_FREEZER=3Dy<br>CONFIG_CGROUP=
_DEVICE=3Dy<br>
CONFIG_CPUSETS=3Dy<br>CONFIG_PROC_PID_CPUSET=3Dy<br>CONFIG_CGROUP_CPUACCT=
=3Dy<br>CONFIG_RESOURCE_COUNTERS=3Dy<br>CONFIG_CGROUP_MEM_RES_CTLR=3Dy<br>C=
ONFIG_CGROUP_MEM_RES_CTLR_SWAP=3Dy<br>CONFIG_CGROUP_SCHED=3Dy<br>CONFIG_FAI=
R_GROUP_SCHED=3Dy<br>
CONFIG_RT_GROUP_SCHED=3Dy<br>CONFIG_MM_OWNER=3Dy<br># CONFIG_SYSFS_DEPRECAT=
ED_V2 is not set<br>CONFIG_RELAY=3Dy<br>CONFIG_NAMESPACES=3Dy<br>CONFIG_UTS=
_NS=3Dy<br>CONFIG_IPC_NS=3Dy<br>CONFIG_USER_NS=3Dy<br>CONFIG_PID_NS=3Dy<br>=
CONFIG_NET_NS=3Dy<br>
CONFIG_BLK_DEV_INITRD=3Dy<br>CONFIG_INITRAMFS_SOURCE=3D&quot;&quot;<br>CONF=
IG_RD_GZIP=3Dy<br>CONFIG_RD_BZIP2=3Dy<br>CONFIG_RD_LZMA=3Dy<br>CONFIG_RD_LZ=
O=3Dy<br>CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy<br>CONFIG_SYSCTL=3Dy<br>CONFIG_ANO=
N_INODES=3Dy<br>
# CONFIG_EMBEDDED is not set<br>CONFIG_UID16=3Dy<br>CONFIG_SYSCTL_SYSCALL=
=3Dy<br>CONFIG_KALLSYMS=3Dy<br>CONFIG_KALLSYMS_ALL=3Dy<br>CONFIG_KALLSYMS_E=
XTRA_PASS=3Dy<br>CONFIG_HOTPLUG=3Dy<br>CONFIG_PRINTK=3Dy<br>CONFIG_BUG=3Dy<=
br>CONFIG_ELF_CORE=3Dy<br>
CONFIG_PCSPKR_PLATFORM=3Dy<br>CONFIG_BASE_FULL=3Dy<br>CONFIG_FUTEX=3Dy<br>C=
ONFIG_EPOLL=3Dy<br>CONFIG_SIGNALFD=3Dy<br>CONFIG_TIMERFD=3Dy<br>CONFIG_EVEN=
TFD=3Dy<br>CONFIG_SHMEM=3Dy<br>CONFIG_AIO=3Dy<br>CONFIG_HAVE_PERF_EVENTS=3D=
y<br><br>#<br># Kernel Performance Events And Counters<br>
#<br>CONFIG_PERF_EVENTS=3Dy<br># CONFIG_PERF_COUNTERS is not set<br># CONFI=
G_DEBUG_PERF_USE_VMALLOC is not set<br>CONFIG_VM_EVENT_COUNTERS=3Dy<br>CONF=
IG_PCI_QUIRKS=3Dy<br>CONFIG_SLUB_DEBUG=3Dy<br># CONFIG_COMPAT_BRK is not se=
t<br>
# CONFIG_SLAB is not set<br>CONFIG_SLUB=3Dy<br># CONFIG_SLOB is not set<br>=
CONFIG_PROFILING=3Dy<br>CONFIG_TRACEPOINTS=3Dy<br>CONFIG_OPROFILE=3Dm<br># =
CONFIG_OPROFILE_EVENT_MULTIPLEX is not set<br>CONFIG_HAVE_OPROFILE=3Dy<br>C=
ONFIG_KPROBES=3Dy<br>
CONFIG_OPTPROBES=3Dy<br>CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy<br>CONFI=
G_KRETPROBES=3Dy<br>CONFIG_HAVE_IOREMAP_PROT=3Dy<br>CONFIG_HAVE_KPROBES=3Dy=
<br>CONFIG_HAVE_KRETPROBES=3Dy<br>CONFIG_HAVE_OPTPROBES=3Dy<br>CONFIG_HAVE_=
ARCH_TRACEHOOK=3Dy<br>
CONFIG_HAVE_DMA_ATTRS=3Dy<br>CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy<br>C=
ONFIG_HAVE_DMA_API_DEBUG=3Dy<br>CONFIG_HAVE_HW_BREAKPOINT=3Dy<br>CONFIG_HAV=
E_USER_RETURN_NOTIFIER=3Dy<br><br>#<br># GCOV-based kernel profiling<br>#<b=
r># CONFIG_GCOV_KERNEL is not set<br>
CONFIG_SLOW_WORK=3Dy<br># CONFIG_SLOW_WORK_DEBUG is not set<br># CONFIG_HAV=
E_GENERIC_DMA_COHERENT is not set<br>CONFIG_SLABINFO=3Dy<br>CONFIG_RT_MUTEX=
ES=3Dy<br>CONFIG_BASE_SMALL=3D0<br>CONFIG_MODULES=3Dy<br># CONFIG_MODULE_FO=
RCE_LOAD is not set<br>
CONFIG_MODULE_UNLOAD=3Dy<br># CONFIG_MODULE_FORCE_UNLOAD is not set<br># CO=
NFIG_MODVERSIONS is not set<br>CONFIG_MODULE_SRCVERSION_ALL=3Dy<br>CONFIG_S=
TOP_MACHINE=3Dy<br>CONFIG_BLOCK=3Dy<br>CONFIG_BLK_DEV_BSG=3Dy<br>CONFIG_BLK=
_DEV_INTEGRITY=3Dy<br>
CONFIG_BLOCK_COMPAT=3Dy<br><br>#<br># IO Schedulers<br>#<br>CONFIG_IOSCHED_=
NOOP=3Dy<br>CONFIG_IOSCHED_DEADLINE=3Dy<br>CONFIG_IOSCHED_CFQ=3Dy<br># CONF=
IG_CFQ_GROUP_IOSCHED is not set<br>CONFIG_DEFAULT_DEADLINE=3Dy<br># CONFIG_=
DEFAULT_CFQ is not set<br>
# CONFIG_DEFAULT_NOOP is not set<br>CONFIG_DEFAULT_IOSCHED=3D&quot;deadline=
&quot;<br># CONFIG_INLINE_SPIN_TRYLOCK is not set<br># CONFIG_INLINE_SPIN_T=
RYLOCK_BH is not set<br># CONFIG_INLINE_SPIN_LOCK is not set<br># CONFIG_IN=
LINE_SPIN_LOCK_BH is not set<br>
# CONFIG_INLINE_SPIN_LOCK_IRQ is not set<br># CONFIG_INLINE_SPIN_LOCK_IRQSA=
VE is not set<br>CONFIG_INLINE_SPIN_UNLOCK=3Dy<br># CONFIG_INLINE_SPIN_UNLO=
CK_BH is not set<br>CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy<br># CONFIG_INLINE_SP=
IN_UNLOCK_IRQRESTORE is not set<br>
# CONFIG_INLINE_READ_TRYLOCK is not set<br># CONFIG_INLINE_READ_LOCK is not=
 set<br># CONFIG_INLINE_READ_LOCK_BH is not set<br># CONFIG_INLINE_READ_LOC=
K_IRQ is not set<br># CONFIG_INLINE_READ_LOCK_IRQSAVE is not set<br>CONFIG_=
INLINE_READ_UNLOCK=3Dy<br>
# CONFIG_INLINE_READ_UNLOCK_BH is not set<br>CONFIG_INLINE_READ_UNLOCK_IRQ=
=3Dy<br># CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set<br># CONFIG_INLIN=
E_WRITE_TRYLOCK is not set<br># CONFIG_INLINE_WRITE_LOCK is not set<br># CO=
NFIG_INLINE_WRITE_LOCK_BH is not set<br>
# CONFIG_INLINE_WRITE_LOCK_IRQ is not set<br># CONFIG_INLINE_WRITE_LOCK_IRQ=
SAVE is not set<br>CONFIG_INLINE_WRITE_UNLOCK=3Dy<br># CONFIG_INLINE_WRITE_=
UNLOCK_BH is not set<br>CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy<br># CONFIG_INLI=
NE_WRITE_UNLOCK_IRQRESTORE is not set<br>
CONFIG_MUTEX_SPIN_ON_OWNER=3Dy<br><br>#<br># Real-time sub-system<br>#<br>C=
ONFIG_XENOMAI=3Dy<br>CONFIG_XENO_GENERIC_STACKPOOL=3Dy<br>CONFIG_XENO_FASTS=
YNCH=3Dy<br>CONFIG_XENO_OPT_NUCLEUS=3Dy<br>CONFIG_XENO_OPT_PERVASIVE=3Dy<br=
>CONFIG_XENO_OPT_PRIOCPL=3Dy<br>
CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy<br># CONFIG_XENO_OPT_SCHED_CLASSES is not=
 set<br>CONFIG_XENO_OPT_PIPE=3Dy<br>CONFIG_XENO_OPT_MAP=3Dy<br>CONFIG_XENO_=
OPT_PIPE_NRDEV=3D32<br>CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512<br>CONFIG_XEN=
O_OPT_SYS_HEAPSZ=3D256<br>
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D128<br>CONFIG_XENO_OPT_SEM_HEAPSZ=3D12<br=
>CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=3D12<br>CONFIG_XENO_OPT_STATS=3Dy<br># C=
ONFIG_XENO_OPT_DEBUG is not set<br>CONFIG_XENO_OPT_SHIRQ=3Dy<br>CONFIG_XENO=
_OPT_SELECT=3Dy<br>
<br>#<br># Timing<br>#<br># CONFIG_XENO_OPT_TIMING_PERIODIC is not set<br>C=
ONFIG_XENO_OPT_TIMING_VIRTICK=3D1000<br>CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0=
<br><br>#<br># Scalability<br>#<br># CONFIG_XENO_OPT_SCALABLE_SCHED is not =
set<br>
CONFIG_XENO_OPT_TIMER_LIST=3Dy<br># CONFIG_XENO_OPT_TIMER_HEAP is not set<b=
r># CONFIG_XENO_OPT_TIMER_WHEEL is not set<br><br>#<br># Machine<br>#<br>CO=
NFIG_XENO_HW_FPU=3Dy<br><br>#<br># NMI watchdog<br>#<br># CONFIG_XENO_HW_NM=
I_DEBUG_LATENCY is not set<br>
<br>#<br># SMI workaround<br>#<br># CONFIG_XENO_HW_SMI_DETECT_DISABLE is no=
t set<br>CONFIG_XENO_HW_SMI_DETECT=3Dy<br>CONFIG_XENO_HW_SMI_WORKAROUND=3Dy=
<br>CONFIG_XENO_HW_SMI_ALL=3Dy<br><br>#<br># Interfaces<br>#<br>CONFIG_XENO=
_SKIN_NATIVE=3Dy<br>
CONFIG_XENO_OPT_NATIVE_PERIOD=3D0<br>CONFIG_XENO_OPT_NATIVE_PIPE=3Dy<br>CON=
FIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024<br>CONFIG_XENO_OPT_NATIVE_SEM=3Dy<br>=
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy<br>CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy<br>CON=
FIG_XENO_OPT_NATIVE_COND=3Dy<br>
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy<br>CONFIG_XENO_OPT_NATIVE_BUFFER=3Dy<br>CO=
NFIG_XENO_OPT_NATIVE_HEAP=3Dy<br>CONFIG_XENO_OPT_NATIVE_ALARM=3Dy<br>CONFIG=
_XENO_OPT_NATIVE_MPS=3Dy<br>CONFIG_XENO_OPT_NATIVE_INTR=3Dy<br>CONFIG_XENO_=
SKIN_POSIX=3Dy<br>
CONFIG_XENO_OPT_POSIX_PERIOD=3D0<br>CONFIG_XENO_OPT_POSIX_SHM=3Dy<br>CONFIG=
_XENO_OPT_POSIX_INTR=3Dy<br>CONFIG_XENO_OPT_POSIX_SELECT=3Dy<br># CONFIG_XE=
NO_OPT_DEBUG_POSIX is not set<br># CONFIG_XENO_SKIN_PSOS is not set<br># CO=
NFIG_XENO_SKIN_UITRON is not set<br>
# CONFIG_XENO_SKIN_VRTX is not set<br># CONFIG_XENO_SKIN_VXWORKS is not set=
<br># CONFIG_XENO_SKIN_RTAI is not set<br># CONFIG_XENO_OPT_NOWARN_DEPRECAT=
ED is not set<br>CONFIG_XENO_SKIN_RTDM=3Dy<br>CONFIG_XENO_OPT_RTDM_PERIOD=
=3D0<br>
CONFIG_XENO_OPT_RTDM_FILDES=3D128<br>CONFIG_XENO_OPT_RTDM_SELECT=3Dy<br><br=
>#<br># Drivers<br>#<br><br>#<br># Serial drivers<br>#<br># CONFIG_XENO_DRI=
VERS_16550A is not set<br><br>#<br># Testing drivers<br>#<br># CONFIG_XENO_=
DRIVERS_TESTING_LEGACY_NAMES is not set<br>
CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy<br># CONFIG_XENO_DRIVERS_KLATENCY is not=
 set<br># CONFIG_XENO_DRIVERS_IRQBENCH is not set<br>CONFIG_XENO_DRIVERS_SW=
ITCHTEST=3Dy<br># CONFIG_XENO_DRIVERS_SIGTEST is not set<br># CONFIG_XENO_D=
RIVERS_RTDMTEST is not set<br>
<br>#<br># CAN drivers<br>#<br># CONFIG_XENO_DRIVERS_CAN is not set<br><br>=
#<br># ANALOGY drivers<br>#<br># CONFIG_XENO_DRIVERS_ANALOGY is not set<br>=
<br>#<br># Real-time IPC drivers<br>#<br>CONFIG_XENO_DRIVERS_RTIPC=3Dm<br>
CONFIG_XENO_DRIVERS_RTIPC_XDDP=3Dy<br>CONFIG_XENO_DRIVERS_RTIPC_IDDP=3Dy<br=
>CONFIG_XENO_OPT_IDDP_NRPORT=3D32<br>CONFIG_XENO_DRIVERS_RTIPC_BUFP=3Dy<br>=
CONFIG_XENO_OPT_BUFP_NRPORT=3D32<br>CONFIG_FREEZER=3Dy<br><br>#<br># Proces=
sor type and features<br>
#<br>CONFIG_TICK_ONESHOT=3Dy<br>CONFIG_NO_HZ=3Dy<br># CONFIG_HIGH_RES_TIMER=
S is not set<br>CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy<br>CONFIG_SMP=3Dy<br>#=
 CONFIG_X86_X2APIC is not set<br># CONFIG_SPARSE_IRQ is not set<br>CONFIG_X=
86_MPPARSE=3Dy<br>
CONFIG_X86_EXTENDED_PLATFORM=3Dy<br># CONFIG_X86_VSMP is not set<br>CONFIG_=
X86_SUPPORTS_MEMORY_FAILURE=3Dy<br>CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy<br>C=
ONFIG_NO_BOOTMEM=3Dy<br># CONFIG_MEMTEST is not set<br># CONFIG_M386 is not=
 set<br>
# CONFIG_M486 is not set<br># CONFIG_M586 is not set<br># CONFIG_M586TSC is=
 not set<br># CONFIG_M586MMX is not set<br># CONFIG_M686 is not set<br># CO=
NFIG_MPENTIUMII is not set<br># CONFIG_MPENTIUMIII is not set<br># CONFIG_M=
PENTIUMM is not set<br>
# CONFIG_MPENTIUM4 is not set<br># CONFIG_MK6 is not set<br># CONFIG_MK7 is=
 not set<br># CONFIG_MK8 is not set<br># CONFIG_MCRUSOE is not set<br># CON=
FIG_MEFFICEON is not set<br># CONFIG_MWINCHIPC6 is not set<br># CONFIG_MWIN=
CHIP3D is not set<br>
# CONFIG_MGEODEGX1 is not set<br># CONFIG_MGEODE_LX is not set<br># CONFIG_=
MCYRIXIII is not set<br># CONFIG_MVIAC3_2 is not set<br># CONFIG_MVIAC7 is =
not set<br># CONFIG_MPSC is not set<br>CONFIG_MCORE2=3Dy<br># CONFIG_MATOM =
is not set<br>
# CONFIG_GENERIC_CPU is not set<br>CONFIG_X86_CPU=3Dy<br>CONFIG_X86_INTERNO=
DE_CACHE_SHIFT=3D7<br>CONFIG_X86_CMPXCHG=3Dy<br>CONFIG_X86_L1_CACHE_SHIFT=
=3D6<br>CONFIG_X86_XADD=3Dy<br>CONFIG_X86_WP_WORKS_OK=3Dy<br>CONFIG_X86_INT=
EL_USERCOPY=3Dy<br>
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy<br>CONFIG_X86_P6_NOP=3Dy<br>CONFIG_X86_TSC=
=3Dy<br>CONFIG_X86_CMPXCHG64=3Dy<br>CONFIG_X86_CMOV=3Dy<br>CONFIG_X86_MINIM=
UM_CPU_FAMILY=3D64<br>CONFIG_X86_DEBUGCTLMSR=3Dy<br>CONFIG_CPU_SUP_INTEL=3D=
y<br>CONFIG_CPU_SUP_AMD=3Dy<br>
CONFIG_CPU_SUP_CENTAUR=3Dy<br># CONFIG_X86_DS is not set<br>CONFIG_HPET_TIM=
ER=3Dy<br>CONFIG_HPET_EMULATE_RTC=3Dy<br>CONFIG_DMI=3Dy<br>CONFIG_GART_IOMM=
U=3Dy<br>CONFIG_CALGARY_IOMMU=3Dy<br>CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAUL=
T=3Dy<br>CONFIG_AMD_IOMMU=3Dy<br>
CONFIG_AMD_IOMMU_STATS=3Dy<br>CONFIG_SWIOTLB=3Dy<br>CONFIG_IOMMU_HELPER=3Dy=
<br>CONFIG_IOMMU_API=3Dy<br># CONFIG_MAXSMP is not set<br>CONFIG_NR_CPUS=3D=
8<br>CONFIG_SCHED_SMT=3Dy<br>CONFIG_SCHED_MC=3Dy<br>CONFIG_PREEMPT_NONE=3Dy=
<br># CONFIG_PREEMPT_VOLUNTARY is not set<br>
# CONFIG_PREEMPT is not set<br>CONFIG_IPIPE=3Dy<br>CONFIG_IPIPE_DOMAINS=3D8=
<br>CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy<br># CONFIG_IPIPE_UNMASKED_CONTEXT_SW=
ITCH is not set<br>CONFIG_X86_LOCAL_APIC=3Dy<br>CONFIG_X86_IO_APIC=3Dy<br>C=
ONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy<br>
CONFIG_X86_MCE=3Dy<br>CONFIG_X86_MCE_INTEL=3Dy<br>CONFIG_X86_MCE_AMD=3Dy<br=
>CONFIG_X86_MCE_THRESHOLD=3Dy<br># CONFIG_X86_MCE_INJECT is not set<br>CONF=
IG_X86_THERMAL_VECTOR=3Dy<br>CONFIG_I8K=3Dm<br>CONFIG_MICROCODE=3Dm<br>CONF=
IG_MICROCODE_INTEL=3Dy<br>
CONFIG_MICROCODE_AMD=3Dy<br>CONFIG_MICROCODE_OLD_INTERFACE=3Dy<br>CONFIG_X8=
6_MSR=3Dy<br>CONFIG_X86_CPUID=3Dy<br>CONFIG_ARCH_PHYS_ADDR_T_64BIT=3Dy<br>C=
ONFIG_DIRECT_GBPAGES=3Dy<br>CONFIG_NUMA=3Dy<br>CONFIG_K8_NUMA=3Dy<br>CONFIG=
_X86_64_ACPI_NUMA=3Dy<br>
CONFIG_NODES_SPAN_OTHER_NODES=3Dy<br># CONFIG_NUMA_EMU is not set<br>CONFIG=
_NODES_SHIFT=3D9<br>CONFIG_ARCH_PROC_KCORE_TEXT=3Dy<br>CONFIG_ARCH_SPARSEME=
M_DEFAULT=3Dy<br>CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy<br>CONFIG_ARCH_SELECT_MEM=
ORY_MODEL=3Dy<br>
CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000<br>CONFIG_SELECT_MEMORY_M=
ODEL=3Dy<br># CONFIG_FLATMEM_MANUAL is not set<br># CONFIG_DISCONTIGMEM_MAN=
UAL is not set<br>CONFIG_SPARSEMEM_MANUAL=3Dy<br>CONFIG_SPARSEMEM=3Dy<br>CO=
NFIG_NEED_MULTIPLE_NODES=3Dy<br>
CONFIG_HAVE_MEMORY_PRESENT=3Dy<br>CONFIG_SPARSEMEM_EXTREME=3Dy<br>CONFIG_SP=
ARSEMEM_VMEMMAP_ENABLE=3Dy<br>CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=3Dy<b=
r>CONFIG_SPARSEMEM_VMEMMAP=3Dy<br># CONFIG_MEMORY_HOTPLUG is not set<br>CON=
FIG_PAGEFLAGS_EXTENDED=3Dy<br>
CONFIG_SPLIT_PTLOCK_CPUS=3D4<br>CONFIG_MIGRATION=3Dy<br>CONFIG_PHYS_ADDR_T_=
64BIT=3Dy<br>CONFIG_ZONE_DMA_FLAG=3D1<br>CONFIG_BOUNCE=3Dy<br>CONFIG_VIRT_T=
O_BUS=3Dy<br># CONFIG_KSM is not set<br>CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096=
<br>CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy<br>
# CONFIG_MEMORY_FAILURE is not set<br># CONFIG_X86_CHECK_BIOS_CORRUPTION is=
 not set<br>CONFIG_X86_RESERVE_LOW_64K=3Dy<br>CONFIG_MTRR=3Dy<br>CONFIG_MTR=
R_SANITIZER=3Dy<br>CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D1<br>CONFIG_MTRR_=
SANITIZER_SPARE_REG_NR_DEFAULT=3D1<br>
CONFIG_X86_PAT=3Dy<br>CONFIG_ARCH_USES_PG_UNCACHED=3Dy<br>CONFIG_EFI=3Dy<br=
>CONFIG_SECCOMP=3Dy<br># CONFIG_CC_STACKPROTECTOR is not set<br>CONFIG_HZ_1=
00=3Dy<br># CONFIG_HZ_250 is not set<br># CONFIG_HZ_300 is not set<br># CON=
FIG_HZ_1000 is not set<br>
CONFIG_HZ=3D100<br># CONFIG_SCHED_HRTICK is not set<br>CONFIG_KEXEC=3Dy<br>=
CONFIG_CRASH_DUMP=3Dy<br>CONFIG_PHYSICAL_START=3D0x1000000<br>CONFIG_RELOCA=
TABLE=3Dy<br>CONFIG_PHYSICAL_ALIGN=3D0x1000000<br>CONFIG_HOTPLUG_CPU=3Dy<br=
># CONFIG_COMPAT_VDSO is not set<br>
# CONFIG_CMDLINE_BOOL is not set<br>CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy<b=
r>CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=3Dy<br><br>#<br># Power management and =
ACPI options<br>#<br>CONFIG_PM=3Dy<br># CONFIG_PM_DEBUG is not set<br># CON=
FIG_SUSPEND is not set<br>
# CONFIG_HIBERNATION is not set<br># CONFIG_PM_RUNTIME is not set<br>CONFIG=
_ACPI=3Dy<br>CONFIG_ACPI_PROCFS=3Dy<br>CONFIG_ACPI_PROCFS_POWER=3Dy<br># CO=
NFIG_ACPI_POWER_METER is not set<br>CONFIG_ACPI_SYSFS_POWER=3Dy<br>CONFIG_A=
CPI_PROC_EVENT=3Dy<br>
CONFIG_ACPI_AC=3Dy<br>CONFIG_ACPI_BATTERY=3Dy<br>CONFIG_ACPI_BUTTON=3Dy<br>=
CONFIG_ACPI_VIDEO=3Dm<br>CONFIG_ACPI_FAN=3Dy<br>CONFIG_ACPI_DOCK=3Dy<br># C=
ONFIG_ACPI_PROCESSOR is not set<br>CONFIG_ACPI_NUMA=3Dy<br># CONFIG_ACPI_CU=
STOM_DSDT is not set<br>
CONFIG_ACPI_BLACKLIST_YEAR=3D0<br># CONFIG_ACPI_DEBUG is not set<br>CONFIG_=
ACPI_PCI_SLOT=3Dy<br>CONFIG_X86_PM_TIMER=3Dy<br>CONFIG_ACPI_CONTAINER=3Dy<b=
r>CONFIG_ACPI_SBS=3Dm<br># CONFIG_SFI is not set<br><br>#<br># CPU Frequenc=
y scaling<br>
#<br># CONFIG_CPU_FREQ is not set<br>CONFIG_CPU_IDLE=3Dy<br>CONFIG_CPU_IDLE=
_GOV_LADDER=3Dy<br>CONFIG_CPU_IDLE_GOV_MENU=3Dy<br><br>#<br># Memory power =
savings<br>#<br>CONFIG_I7300_IDLE_IOAT_CHANNEL=3Dy<br>CONFIG_I7300_IDLE=3Dm=
<br><br>
#<br># Bus options (PCI etc.)<br>#<br>CONFIG_PCI=3Dy<br>CONFIG_PCI_DIRECT=
=3Dy<br>CONFIG_PCI_MMCONFIG=3Dy<br>CONFIG_PCI_DOMAINS=3Dy<br>CONFIG_DMAR=3D=
y<br># CONFIG_DMAR_DEFAULT_ON is not set<br>CONFIG_DMAR_FLOPPY_WA=3Dy<br>CO=
NFIG_INTR_REMAP=3Dy<br>
CONFIG_PCIEPORTBUS=3Dy<br>CONFIG_HOTPLUG_PCI_PCIE=3Dy<br>CONFIG_PCIEAER=3Dy=
<br># CONFIG_PCIE_ECRC is not set<br># CONFIG_PCIEAER_INJECT is not set<br>=
CONFIG_PCIEASPM=3Dy<br># CONFIG_PCIEASPM_DEBUG is not set<br>CONFIG_ARCH_SU=
PPORTS_MSI=3Dy<br>
CONFIG_PCI_MSI=3Dy<br># CONFIG_PCI_DEBUG is not set<br>CONFIG_PCI_STUB=3Dy<=
br>CONFIG_HT_IRQ=3Dy<br># CONFIG_PCI_IOV is not set<br>CONFIG_PCI_IOAPIC=3D=
y<br>CONFIG_ISA_DMA_API=3Dy<br>CONFIG_K8_NB=3Dy<br>CONFIG_PCCARD=3Dy<br>CON=
FIG_PCMCIA=3Dy<br>
CONFIG_PCMCIA_LOAD_CIS=3Dy<br>CONFIG_CARDBUS=3Dy<br><br>#<br># PC-card brid=
ges<br>#<br>CONFIG_YENTA=3Dm<br>CONFIG_YENTA_O2=3Dy<br>CONFIG_YENTA_RICOH=
=3Dy<br>CONFIG_YENTA_TI=3Dy<br>CONFIG_YENTA_ENE_TUNE=3Dy<br>CONFIG_YENTA_TO=
SHIBA=3Dy<br>CONFIG_PD6729=3Dm<br>
CONFIG_I82092=3Dm<br>CONFIG_PCCARD_NONSTATIC=3Dm<br>CONFIG_HOTPLUG_PCI=3Dy<=
br>CONFIG_HOTPLUG_PCI_FAKE=3Dm<br>CONFIG_HOTPLUG_PCI_ACPI=3Dy<br>CONFIG_HOT=
PLUG_PCI_ACPI_IBM=3Dm<br># CONFIG_HOTPLUG_PCI_CPCI is not set<br>CONFIG_HOT=
PLUG_PCI_SHPC=3Dm<br>
<br>#<br># Executable file formats / Emulations<br>#<br>CONFIG_BINFMT_ELF=
=3Dy<br>CONFIG_COMPAT_BINFMT_ELF=3Dy<br>CONFIG_CORE_DUMP_DEFAULT_ELF_HEADER=
S=3Dy<br># CONFIG_HAVE_AOUT is not set<br>CONFIG_BINFMT_MISC=3Dy<br>CONFIG_=
IA32_EMULATION=3Dy<br>
# CONFIG_IA32_AOUT is not set<br>CONFIG_COMPAT=3Dy<br>CONFIG_COMPAT_FOR_U64=
_ALIGNMENT=3Dy<br>CONFIG_SYSVIPC_COMPAT=3Dy<br>CONFIG_NET=3Dy<br>CONFIG_COM=
PAT_NETLINK_MESSAGES=3Dy<br><br>#<br># Networking options<br>#<br>CONFIG_PA=
CKET=3Dy<br>
CONFIG_UNIX=3Dy<br>CONFIG_XFRM=3Dy<br>CONFIG_XFRM_USER=3Dy<br>CONFIG_XFRM_S=
UB_POLICY=3Dy<br>CONFIG_XFRM_MIGRATE=3Dy<br>CONFIG_XFRM_STATISTICS=3Dy<br>C=
ONFIG_XFRM_IPCOMP=3Dm<br>CONFIG_NET_KEY=3Dm<br>CONFIG_NET_KEY_MIGRATE=3Dy<b=
r>CONFIG_INET=3Dy<br>
CONFIG_IP_MULTICAST=3Dy<br>CONFIG_IP_ADVANCED_ROUTER=3Dy<br>CONFIG_ASK_IP_F=
IB_HASH=3Dy<br># CONFIG_IP_FIB_TRIE is not set<br>CONFIG_IP_FIB_HASH=3Dy<br=
>CONFIG_IP_MULTIPLE_TABLES=3Dy<br>CONFIG_IP_ROUTE_MULTIPATH=3Dy<br>CONFIG_I=
P_ROUTE_VERBOSE=3Dy<br>
# CONFIG_IP_PNP is not set<br>CONFIG_NET_IPIP=3Dm<br>CONFIG_NET_IPGRE=3Dm<b=
r>CONFIG_NET_IPGRE_BROADCAST=3Dy<br>CONFIG_IP_MROUTE=3Dy<br>CONFIG_IP_PIMSM=
_V1=3Dy<br>CONFIG_IP_PIMSM_V2=3Dy<br># CONFIG_ARPD is not set<br>CONFIG_SYN=
_COOKIES=3Dy<br>
CONFIG_INET_AH=3Dm<br>CONFIG_INET_ESP=3Dm<br>CONFIG_INET_IPCOMP=3Dm<br>CONF=
IG_INET_XFRM_TUNNEL=3Dm<br>CONFIG_INET_TUNNEL=3Dm<br>CONFIG_INET_XFRM_MODE_=
TRANSPORT=3Dm<br>CONFIG_INET_XFRM_MODE_TUNNEL=3Dm<br>CONFIG_INET_XFRM_MODE_=
BEET=3Dm<br>
CONFIG_INET_LRO=3Dy<br>CONFIG_INET_DIAG=3Dm<br>CONFIG_INET_TCP_DIAG=3Dm<br>=
CONFIG_TCP_CONG_ADVANCED=3Dy<br>CONFIG_TCP_CONG_BIC=3Dm<br>CONFIG_TCP_CONG_=
CUBIC=3Dy<br>CONFIG_TCP_CONG_WESTWOOD=3Dm<br>CONFIG_TCP_CONG_HTCP=3Dm<br>CO=
NFIG_TCP_CONG_HSTCP=3Dm<br>
CONFIG_TCP_CONG_HYBLA=3Dm<br>CONFIG_TCP_CONG_VEGAS=3Dm<br>CONFIG_TCP_CONG_S=
CALABLE=3Dm<br>CONFIG_TCP_CONG_LP=3Dm<br>CONFIG_TCP_CONG_VENO=3Dm<br>CONFIG=
_TCP_CONG_YEAH=3Dm<br>CONFIG_TCP_CONG_ILLINOIS=3Dm<br># CONFIG_DEFAULT_BIC =
is not set<br>
CONFIG_DEFAULT_CUBIC=3Dy<br># CONFIG_DEFAULT_HTCP is not set<br># CONFIG_DE=
FAULT_VEGAS is not set<br># CONFIG_DEFAULT_WESTWOOD is not set<br># CONFIG_=
DEFAULT_RENO is not set<br>CONFIG_DEFAULT_TCP_CONG=3D&quot;cubic&quot;<br>C=
ONFIG_TCP_MD5SIG=3Dy<br>
# CONFIG_IPV6 is not set<br>CONFIG_NETLABEL=3Dy<br>CONFIG_NETWORK_SECMARK=
=3Dy<br>CONFIG_NETFILTER=3Dy<br># CONFIG_NETFILTER_DEBUG is not set<br>CONF=
IG_NETFILTER_ADVANCED=3Dy<br>CONFIG_BRIDGE_NETFILTER=3Dy<br><br>#<br># Core=
 Netfilter Configuration<br>
#<br>CONFIG_NETFILTER_NETLINK=3Dm<br>CONFIG_NETFILTER_NETLINK_QUEUE=3Dm<br>=
CONFIG_NETFILTER_NETLINK_LOG=3Dm<br>CONFIG_NF_CONNTRACK=3Dy<br>CONFIG_NF_CT=
_ACCT=3Dy<br>CONFIG_NF_CONNTRACK_MARK=3Dy<br>CONFIG_NF_CONNTRACK_SECMARK=3D=
y<br>CONFIG_NF_CONNTRACK_EVENTS=3Dy<br>
CONFIG_NF_CT_PROTO_DCCP=3Dm<br>CONFIG_NF_CT_PROTO_GRE=3Dm<br>CONFIG_NF_CT_P=
ROTO_SCTP=3Dm<br>CONFIG_NF_CT_PROTO_UDPLITE=3Dm<br>CONFIG_NF_CONNTRACK_AMAN=
DA=3Dm<br>CONFIG_NF_CONNTRACK_FTP=3Dm<br>CONFIG_NF_CONNTRACK_H323=3Dm<br>CO=
NFIG_NF_CONNTRACK_IRC=3Dm<br>
CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm<br>CONFIG_NF_CONNTRACK_PPTP=3Dm<br>CONFI=
G_NF_CONNTRACK_SANE=3Dm<br>CONFIG_NF_CONNTRACK_SIP=3Dm<br>CONFIG_NF_CONNTRA=
CK_TFTP=3Dm<br>CONFIG_NF_CT_NETLINK=3Dm<br>CONFIG_NETFILTER_TPROXY=3Dm<br>C=
ONFIG_NETFILTER_XTABLES=3Dy<br>
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm<br>CONFIG_NETFILTER_XT_TARGET_CONNM=
ARK=3Dm<br>CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm<br># CONFIG_NETFILTER=
_XT_TARGET_CT is not set<br>CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm<br>CONFIG_N=
ETFILTER_XT_TARGET_HL=3Dm<br>
# CONFIG_NETFILTER_XT_TARGET_LED is not set<br>CONFIG_NETFILTER_XT_TARGET_M=
ARK=3Dm<br>CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm<br>CONFIG_NETFILTER_XT_TARG=
ET_NFQUEUE=3Dm<br>CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm<br>CONFIG_NETFILTE=
R_XT_TARGET_RATEEST=3Dm<br>
CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm<br>CONFIG_NETFILTER_XT_TARGET_TRACE=
=3Dm<br>CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm<br>CONFIG_NETFILTER_XT_TARGE=
T_TCPMSS=3Dm<br>CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm<br># CONFIG_NETF=
ILTER_XT_MATCH_CLUSTER is not set<br>
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm<br>CONFIG_NETFILTER_XT_MATCH_CONNBYTE=
S=3Dm<br>CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm<br>CONFIG_NETFILTER_XT_MAT=
CH_CONNMARK=3Dm<br>CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy<br>CONFIG_NETFIL=
TER_XT_MATCH_DCCP=3Dm<br>
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm<br>CONFIG_NETFILTER_XT_MATCH_ESP=3Dm<br>=
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm<br>CONFIG_NETFILTER_XT_MATCH_HELPER=
=3Dm<br>CONFIG_NETFILTER_XT_MATCH_HL=3Dm<br>CONFIG_NETFILTER_XT_MATCH_IPRAN=
GE=3Dm<br>
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm<br>CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm=
<br>CONFIG_NETFILTER_XT_MATCH_MAC=3Dm<br>CONFIG_NETFILTER_XT_MATCH_MARK=3Dm=
<br>CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm<br>CONFIG_NETFILTER_XT_MATCH_OW=
NER=3Dm<br>
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm<br>CONFIG_NETFILTER_XT_MATCH_PHYSDEV=
=3Dm<br>CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm<br>CONFIG_NETFILTER_XT_MATCH_=
QUOTA=3Dm<br>CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm<br>CONFIG_NETFILTER_XT_M=
ATCH_REALM=3Dm<br>
CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm<br># CONFIG_NETFILTER_XT_MATCH_RECENT_=
PROC_COMPAT is not set<br>CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm<br>CONFIG_NETF=
ILTER_XT_MATCH_SOCKET=3Dm<br>CONFIG_NETFILTER_XT_MATCH_STATE=3Dy<br>CONFIG_=
NETFILTER_XT_MATCH_STATISTIC=3Dm<br>
CONFIG_NETFILTER_XT_MATCH_STRING=3Dm<br>CONFIG_NETFILTER_XT_MATCH_TCPMSS=3D=
m<br>CONFIG_NETFILTER_XT_MATCH_TIME=3Dm<br>CONFIG_NETFILTER_XT_MATCH_U32=3D=
m<br># CONFIG_NETFILTER_XT_MATCH_OSF is not set<br>CONFIG_IP_VS=3Dm<br># CO=
NFIG_IP_VS_DEBUG is not set<br>
CONFIG_IP_VS_TAB_BITS=3D12<br><br>#<br># IPVS transport protocol load balan=
cing support<br>#<br>CONFIG_IP_VS_PROTO_TCP=3Dy<br>CONFIG_IP_VS_PROTO_UDP=
=3Dy<br>CONFIG_IP_VS_PROTO_AH_ESP=3Dy<br>CONFIG_IP_VS_PROTO_ESP=3Dy<br>CONF=
IG_IP_VS_PROTO_AH=3Dy<br>
# CONFIG_IP_VS_PROTO_SCTP is not set<br><br>#<br># IPVS scheduler<br>#<br>C=
ONFIG_IP_VS_RR=3Dm<br>CONFIG_IP_VS_WRR=3Dm<br>CONFIG_IP_VS_LC=3Dm<br>CONFIG=
_IP_VS_WLC=3Dm<br>CONFIG_IP_VS_LBLC=3Dm<br>CONFIG_IP_VS_LBLCR=3Dm<br>CONFIG=
_IP_VS_DH=3Dm<br>
CONFIG_IP_VS_SH=3Dm<br>CONFIG_IP_VS_SED=3Dm<br>CONFIG_IP_VS_NQ=3Dm<br><br>#=
<br># IPVS application helper<br>#<br>CONFIG_IP_VS_FTP=3Dm<br><br>#<br># IP=
: Netfilter Configuration<br>#<br>CONFIG_NF_DEFRAG_IPV4=3Dy<br>CONFIG_NF_CO=
NNTRACK_IPV4=3Dy<br>
# CONFIG_NF_CONNTRACK_PROC_COMPAT is not set<br>CONFIG_IP_NF_QUEUE=3Dm<br>C=
ONFIG_IP_NF_IPTABLES=3Dy<br>CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm<br>CONFIG_IP_NF=
_MATCH_AH=3Dm<br>CONFIG_IP_NF_MATCH_ECN=3Dm<br>CONFIG_IP_NF_MATCH_TTL=3Dm<b=
r>CONFIG_IP_NF_FILTER=3Dy<br>
CONFIG_IP_NF_TARGET_REJECT=3Dy<br>CONFIG_IP_NF_TARGET_LOG=3Dm<br>CONFIG_IP_=
NF_TARGET_ULOG=3Dm<br>CONFIG_NF_NAT=3Dm<br>CONFIG_NF_NAT_NEEDED=3Dy<br>CONF=
IG_IP_NF_TARGET_MASQUERADE=3Dm<br>CONFIG_IP_NF_TARGET_NETMAP=3Dm<br>CONFIG_=
IP_NF_TARGET_REDIRECT=3Dm<br>
CONFIG_NF_NAT_SNMP_BASIC=3Dm<br>CONFIG_NF_NAT_PROTO_DCCP=3Dm<br>CONFIG_NF_N=
AT_PROTO_GRE=3Dm<br>CONFIG_NF_NAT_PROTO_UDPLITE=3Dm<br>CONFIG_NF_NAT_PROTO_=
SCTP=3Dm<br>CONFIG_NF_NAT_FTP=3Dm<br>CONFIG_NF_NAT_IRC=3Dm<br>CONFIG_NF_NAT=
_TFTP=3Dm<br>
CONFIG_NF_NAT_AMANDA=3Dm<br>CONFIG_NF_NAT_PPTP=3Dm<br>CONFIG_NF_NAT_H323=3D=
m<br>CONFIG_NF_NAT_SIP=3Dm<br>CONFIG_IP_NF_MANGLE=3Dm<br>CONFIG_IP_NF_TARGE=
T_CLUSTERIP=3Dm<br>CONFIG_IP_NF_TARGET_ECN=3Dm<br>CONFIG_IP_NF_TARGET_TTL=
=3Dm<br>CONFIG_IP_NF_RAW=3Dm<br>
CONFIG_IP_NF_SECURITY=3Dm<br>CONFIG_IP_NF_ARPTABLES=3Dm<br>CONFIG_IP_NF_ARP=
FILTER=3Dm<br>CONFIG_IP_NF_ARP_MANGLE=3Dm<br><br>#<br># DECnet: Netfilter C=
onfiguration<br>#<br># CONFIG_DECNET_NF_GRABULATOR is not set<br>CONFIG_BRI=
DGE_NF_EBTABLES=3Dm<br>
CONFIG_BRIDGE_EBT_BROUTE=3Dm<br>CONFIG_BRIDGE_EBT_T_FILTER=3Dm<br>CONFIG_BR=
IDGE_EBT_T_NAT=3Dm<br>CONFIG_BRIDGE_EBT_802_3=3Dm<br>CONFIG_BRIDGE_EBT_AMON=
G=3Dm<br>CONFIG_BRIDGE_EBT_ARP=3Dm<br>CONFIG_BRIDGE_EBT_IP=3Dm<br>CONFIG_BR=
IDGE_EBT_LIMIT=3Dm<br>
CONFIG_BRIDGE_EBT_MARK=3Dm<br>CONFIG_BRIDGE_EBT_PKTTYPE=3Dm<br>CONFIG_BRIDG=
E_EBT_STP=3Dm<br>CONFIG_BRIDGE_EBT_VLAN=3Dm<br>CONFIG_BRIDGE_EBT_ARPREPLY=
=3Dm<br>CONFIG_BRIDGE_EBT_DNAT=3Dm<br>CONFIG_BRIDGE_EBT_MARK_T=3Dm<br>CONFI=
G_BRIDGE_EBT_REDIRECT=3Dm<br>
CONFIG_BRIDGE_EBT_SNAT=3Dm<br>CONFIG_BRIDGE_EBT_LOG=3Dm<br>CONFIG_BRIDGE_EB=
T_ULOG=3Dm<br>CONFIG_BRIDGE_EBT_NFLOG=3Dm<br>CONFIG_IP_DCCP=3Dm<br>CONFIG_I=
NET_DCCP_DIAG=3Dm<br><br>#<br># DCCP CCIDs Configuration (EXPERIMENTAL)<br>=
#<br># CONFIG_IP_DCCP_CCID2_DEBUG is not set<br>
CONFIG_IP_DCCP_CCID3=3Dy<br># CONFIG_IP_DCCP_CCID3_DEBUG is not set<br>CONF=
IG_IP_DCCP_CCID3_RTO=3D100<br>CONFIG_IP_DCCP_TFRC_LIB=3Dy<br><br>#<br># DCC=
P Kernel Hacking<br>#<br># CONFIG_IP_DCCP_DEBUG is not set<br>CONFIG_NET_DC=
CPPROBE=3Dm<br>
CONFIG_IP_SCTP=3Dm<br># CONFIG_SCTP_DBG_MSG is not set<br># CONFIG_SCTP_DBG=
_OBJCNT is not set<br># CONFIG_SCTP_HMAC_NONE is not set<br>CONFIG_SCTP_HMA=
C_SHA1=3Dy<br># CONFIG_SCTP_HMAC_MD5 is not set<br># CONFIG_RDS is not set<=
br>
CONFIG_TIPC=3Dm<br># CONFIG_TIPC_ADVANCED is not set<br># CONFIG_TIPC_DEBUG=
 is not set<br>CONFIG_ATM=3Dm<br>CONFIG_ATM_CLIP=3Dm<br># CONFIG_ATM_CLIP_N=
O_ICMP is not set<br>CONFIG_ATM_LANE=3Dm<br># CONFIG_ATM_MPOA is not set<br=
>CONFIG_ATM_BR2684=3Dm<br>
# CONFIG_ATM_BR2684_IPFILTER is not set<br>CONFIG_STP=3Dm<br>CONFIG_GARP=3D=
m<br>CONFIG_BRIDGE=3Dm<br>CONFIG_BRIDGE_IGMP_SNOOPING=3Dy<br>CONFIG_NET_DSA=
=3Dy<br>CONFIG_NET_DSA_TAG_DSA=3Dy<br>CONFIG_NET_DSA_TAG_EDSA=3Dy<br>CONFIG=
_NET_DSA_TAG_TRAILER=3Dy<br>
CONFIG_NET_DSA_MV88E6XXX=3Dy<br>CONFIG_NET_DSA_MV88E6060=3Dy<br>CONFIG_NET_=
DSA_MV88E6XXX_NEED_PPU=3Dy<br>CONFIG_NET_DSA_MV88E6131=3Dy<br>CONFIG_NET_DS=
A_MV88E6123_61_65=3Dy<br>CONFIG_VLAN_8021Q=3Dm<br>CONFIG_VLAN_8021Q_GVRP=3D=
y<br>CONFIG_DECNET=3Dm<br>
CONFIG_DECNET_ROUTER=3Dy<br>CONFIG_LLC=3Dm<br># CONFIG_LLC2 is not set<br>C=
ONFIG_IPX=3Dm<br># CONFIG_IPX_INTERN is not set<br>CONFIG_ATALK=3Dm<br>CONF=
IG_DEV_APPLETALK=3Dm<br>CONFIG_IPDDP=3Dm<br>CONFIG_IPDDP_ENCAP=3Dy<br>CONFI=
G_IPDDP_DECAP=3Dy<br>
# CONFIG_X25 is not set<br># CONFIG_LAPB is not set<br># CONFIG_ECONET is n=
ot set<br>CONFIG_WAN_ROUTER=3Dm<br>CONFIG_PHONET=3Dm<br># CONFIG_IEEE802154=
 is not set<br>CONFIG_NET_SCHED=3Dy<br><br>#<br># Queueing/Scheduling<br>#<=
br>
CONFIG_NET_SCH_CBQ=3Dm<br>CONFIG_NET_SCH_HTB=3Dm<br>CONFIG_NET_SCH_HFSC=3Dm=
<br>CONFIG_NET_SCH_ATM=3Dm<br>CONFIG_NET_SCH_PRIO=3Dm<br>CONFIG_NET_SCH_MUL=
TIQ=3Dm<br>CONFIG_NET_SCH_RED=3Dm<br>CONFIG_NET_SCH_SFQ=3Dm<br>CONFIG_NET_S=
CH_TEQL=3Dm<br>
CONFIG_NET_SCH_TBF=3Dm<br>CONFIG_NET_SCH_GRED=3Dm<br>CONFIG_NET_SCH_DSMARK=
=3Dm<br>CONFIG_NET_SCH_NETEM=3Dm<br>CONFIG_NET_SCH_DRR=3Dm<br>CONFIG_NET_SC=
H_INGRESS=3Dm<br><br>#<br># Classification<br>#<br>CONFIG_NET_CLS=3Dy<br>CO=
NFIG_NET_CLS_BASIC=3Dm<br>
CONFIG_NET_CLS_TCINDEX=3Dm<br>CONFIG_NET_CLS_ROUTE4=3Dm<br>CONFIG_NET_CLS_R=
OUTE=3Dy<br>CONFIG_NET_CLS_FW=3Dm<br>CONFIG_NET_CLS_U32=3Dm<br>CONFIG_CLS_U=
32_PERF=3Dy<br>CONFIG_CLS_U32_MARK=3Dy<br>CONFIG_NET_CLS_RSVP=3Dm<br>CONFIG=
_NET_CLS_RSVP6=3Dm<br>
CONFIG_NET_CLS_FLOW=3Dm<br>CONFIG_NET_CLS_CGROUP=3Dy<br>CONFIG_NET_EMATCH=
=3Dy<br>CONFIG_NET_EMATCH_STACK=3D32<br>CONFIG_NET_EMATCH_CMP=3Dm<br>CONFIG=
_NET_EMATCH_NBYTE=3Dm<br>CONFIG_NET_EMATCH_U32=3Dm<br>CONFIG_NET_EMATCH_MET=
A=3Dm<br>CONFIG_NET_EMATCH_TEXT=3Dm<br>
CONFIG_NET_CLS_ACT=3Dy<br>CONFIG_NET_ACT_POLICE=3Dm<br>CONFIG_NET_ACT_GACT=
=3Dm<br>CONFIG_GACT_PROB=3Dy<br>CONFIG_NET_ACT_MIRRED=3Dm<br>CONFIG_NET_ACT=
_IPT=3Dm<br>CONFIG_NET_ACT_NAT=3Dm<br>CONFIG_NET_ACT_PEDIT=3Dm<br>CONFIG_NE=
T_ACT_SIMP=3Dm<br>
CONFIG_NET_ACT_SKBEDIT=3Dm<br>CONFIG_NET_CLS_IND=3Dy<br>CONFIG_NET_SCH_FIFO=
=3Dy<br>CONFIG_DCB=3Dy<br><br>#<br># Network testing<br>#<br>CONFIG_NET_PKT=
GEN=3Dm<br># CONFIG_NET_TCPPROBE is not set<br>CONFIG_NET_DROP_MONITOR=3Dy<=
br>CONFIG_HAMRADIO=3Dy<br>
<br>#<br># Packet Radio protocols<br>#<br>CONFIG_AX25=3Dm<br>CONFIG_AX25_DA=
MA_SLAVE=3Dy<br>CONFIG_NETROM=3Dm<br>CONFIG_ROSE=3Dm<br><br>#<br># AX.25 ne=
twork device drivers<br>#<br>CONFIG_MKISS=3Dm<br>CONFIG_6PACK=3Dm<br>CONFIG=
_BPQETHER=3Dm<br>
CONFIG_BAYCOM_SER_FDX=3Dm<br>CONFIG_BAYCOM_SER_HDX=3Dm<br>CONFIG_BAYCOM_PAR=
=3Dm<br>CONFIG_YAM=3Dm<br>CONFIG_CAN=3Dm<br>CONFIG_CAN_RAW=3Dm<br>CONFIG_CA=
N_BCM=3Dm<br><br>#<br># CAN Device Drivers<br>#<br>CONFIG_CAN_VCAN=3Dm<br>#=
 CONFIG_CAN_DEV is not set<br>
# CONFIG_CAN_DEBUG_DEVICES is not set<br>CONFIG_IRDA=3Dm<br><br>#<br># IrDA=
 protocols<br>#<br>CONFIG_IRLAN=3Dm<br>CONFIG_IRNET=3Dm<br>CONFIG_IRCOMM=3D=
m<br># CONFIG_IRDA_ULTRA is not set<br><br>#<br># IrDA options<br>#<br>CONF=
IG_IRDA_CACHE_LAST_LSAP=3Dy<br>
CONFIG_IRDA_FAST_RR=3Dy<br># CONFIG_IRDA_DEBUG is not set<br><br>#<br># Inf=
rared-port device drivers<br>#<br><br>#<br># SIR device drivers<br>#<br>CON=
FIG_IRTTY_SIR=3Dm<br><br>#<br># Dongle support<br>#<br>CONFIG_DONGLE=3Dy<br=
>CONFIG_ESI_DONGLE=3Dm<br>
CONFIG_ACTISYS_DONGLE=3Dm<br>CONFIG_TEKRAM_DONGLE=3Dm<br>CONFIG_TOIM3232_DO=
NGLE=3Dm<br>CONFIG_LITELINK_DONGLE=3Dm<br>CONFIG_MA600_DONGLE=3Dm<br>CONFIG=
_GIRBIL_DONGLE=3Dm<br>CONFIG_MCP2120_DONGLE=3Dm<br>CONFIG_OLD_BELKIN_DONGLE=
=3Dm<br>CONFIG_ACT200L_DONGLE=3Dm<br>
CONFIG_KINGSUN_DONGLE=3Dm<br>CONFIG_KSDAZZLE_DONGLE=3Dm<br>CONFIG_KS959_DON=
GLE=3Dm<br><br>#<br># FIR device drivers<br>#<br>CONFIG_USB_IRDA=3Dm<br>CON=
FIG_SIGMATEL_FIR=3Dm<br>CONFIG_NSC_FIR=3Dm<br>CONFIG_WINBOND_FIR=3Dm<br>CON=
FIG_SMC_IRCC_FIR=3Dm<br>
CONFIG_ALI_FIR=3Dm<br>CONFIG_VLSI_FIR=3Dm<br>CONFIG_VIA_FIR=3Dm<br>CONFIG_M=
CS_FIR=3Dm<br>CONFIG_BT=3Dm<br>CONFIG_BT_L2CAP=3Dm<br>CONFIG_BT_SCO=3Dm<br>=
CONFIG_BT_RFCOMM=3Dm<br>CONFIG_BT_RFCOMM_TTY=3Dy<br>CONFIG_BT_BNEP=3Dm<br>C=
ONFIG_BT_BNEP_MC_FILTER=3Dy<br>
CONFIG_BT_BNEP_PROTO_FILTER=3Dy<br>CONFIG_BT_CMTP=3Dm<br>CONFIG_BT_HIDP=3Dm=
<br><br>#<br># Bluetooth device drivers<br>#<br>CONFIG_BT_HCIBTUSB=3Dm<br>C=
ONFIG_BT_HCIBTSDIO=3Dm<br>CONFIG_BT_HCIUART=3Dm<br>CONFIG_BT_HCIUART_H4=3Dy=
<br>CONFIG_BT_HCIUART_BCSP=3Dy<br>
CONFIG_BT_HCIUART_LL=3Dy<br>CONFIG_BT_HCIBCM203X=3Dm<br>CONFIG_BT_HCIBPA10X=
=3Dm<br>CONFIG_BT_HCIBFUSB=3Dm<br>CONFIG_BT_HCIDTL1=3Dm<br>CONFIG_BT_HCIBT3=
C=3Dm<br>CONFIG_BT_HCIBLUECARD=3Dm<br>CONFIG_BT_HCIBTUART=3Dm<br>CONFIG_BT_=
HCIVHCI=3Dm<br>
# CONFIG_BT_MRVL is not set<br># CONFIG_BT_ATH3K is not set<br># CONFIG_AF_=
RXRPC is not set<br>CONFIG_FIB_RULES=3Dy<br>CONFIG_WIRELESS=3Dy<br>CONFIG_W=
IRELESS_EXT=3Dy<br>CONFIG_WEXT_CORE=3Dy<br>CONFIG_WEXT_PROC=3Dy<br>CONFIG_W=
EXT_SPY=3Dy<br>
CONFIG_WEXT_PRIV=3Dy<br>CONFIG_CFG80211=3Dm<br># CONFIG_NL80211_TESTMODE is=
 not set<br># CONFIG_CFG80211_DEVELOPER_WARNINGS is not set<br># CONFIG_CFG=
80211_REG_DEBUG is not set<br>CONFIG_CFG80211_DEFAULT_PS=3Dy<br># CONFIG_CF=
G80211_DEBUGFS is not set<br>
# CONFIG_CFG80211_INTERNAL_REGDB is not set<br>CONFIG_CFG80211_WEXT=3Dy<br>=
CONFIG_WIRELESS_EXT_SYSFS=3Dy<br>CONFIG_LIB80211=3Dm<br>CONFIG_LIB80211_CRY=
PT_WEP=3Dm<br>CONFIG_LIB80211_CRYPT_CCMP=3Dm<br>CONFIG_LIB80211_CRYPT_TKIP=
=3Dm<br># CONFIG_LIB80211_DEBUG is not set<br>
CONFIG_MAC80211=3Dm<br>CONFIG_MAC80211_HAS_RC=3Dy<br>CONFIG_MAC80211_RC_MIN=
STREL=3Dy<br># CONFIG_MAC80211_RC_DEFAULT_PID is not set<br>CONFIG_MAC80211=
_RC_DEFAULT_MINSTREL=3Dy<br>CONFIG_MAC80211_RC_DEFAULT=3D&quot;minstrel&quo=
t;<br>
CONFIG_MAC80211_MESH=3Dy<br>CONFIG_MAC80211_LEDS=3Dy<br>CONFIG_MAC80211_DEB=
UGFS=3Dy<br># CONFIG_MAC80211_DEBUG_MENU is not set<br>CONFIG_WIMAX=3Dy<br>=
CONFIG_WIMAX_DEBUG_LEVEL=3D8<br>CONFIG_RFKILL=3Dy<br>CONFIG_RFKILL_LEDS=3Dy=
<br>CONFIG_RFKILL_INPUT=3Dy<br>
CONFIG_NET_9P=3Dm<br>CONFIG_NET_9P_RDMA=3Dm<br># CONFIG_NET_9P_DEBUG is not=
 set<br><br>#<br># Device Drivers<br>#<br><br>#<br># Generic Driver Options=
<br>#<br>CONFIG_UEVENT_HELPER_PATH=3D&quot;&quot;<br># CONFIG_DEVTMPFS is n=
ot set<br>
CONFIG_STANDALONE=3Dy<br>CONFIG_PREVENT_FIRMWARE_BUILD=3Dy<br>CONFIG_FW_LOA=
DER=3Dy<br># CONFIG_FIRMWARE_IN_KERNEL is not set<br>CONFIG_EXTRA_FIRMWARE=
=3D&quot;&quot;<br># CONFIG_DEBUG_DRIVER is not set<br>CONFIG_DEBUG_DEVRES=
=3Dy<br>
# CONFIG_SYS_HYPERVISOR is not set<br>CONFIG_CONNECTOR=3Dy<br>CONFIG_PROC_E=
VENTS=3Dy<br>CONFIG_MTD=3Dm<br># CONFIG_MTD_DEBUG is not set<br># CONFIG_MT=
D_TESTS is not set<br>CONFIG_MTD_CONCAT=3Dm<br>CONFIG_MTD_PARTITIONS=3Dy<br=
>CONFIG_MTD_REDBOOT_PARTS=3Dm<br>
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=3D-1<br># CONFIG_MTD_REDBOOT_PARTS_UNALL=
OCATED is not set<br># CONFIG_MTD_REDBOOT_PARTS_READONLY is not set<br>CONF=
IG_MTD_AR7_PARTS=3Dm<br><br>#<br># User Modules And Translation Layers<br>#=
<br>
CONFIG_MTD_CHAR=3Dm<br>CONFIG_MTD_BLKDEVS=3Dm<br>CONFIG_MTD_BLOCK=3Dm<br>CO=
NFIG_MTD_BLOCK_RO=3Dm<br>CONFIG_FTL=3Dm<br>CONFIG_NFTL=3Dm<br>CONFIG_NFTL_R=
W=3Dy<br>CONFIG_INFTL=3Dm<br>CONFIG_RFD_FTL=3Dm<br>CONFIG_SSFDC=3Dm<br>CONF=
IG_MTD_OOPS=3Dm<br>
<br>#<br># RAM/ROM/Flash chip drivers<br>#<br>CONFIG_MTD_CFI=3Dm<br>CONFIG_=
MTD_JEDECPROBE=3Dm<br>CONFIG_MTD_GEN_PROBE=3Dm<br># CONFIG_MTD_CFI_ADV_OPTI=
ONS is not set<br>CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy<br>CONFIG_MTD_MAP_BANK_WI=
DTH_2=3Dy<br>
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy<br># CONFIG_MTD_MAP_BANK_WIDTH_8 is not set=
<br># CONFIG_MTD_MAP_BANK_WIDTH_16 is not set<br># CONFIG_MTD_MAP_BANK_WIDT=
H_32 is not set<br>CONFIG_MTD_CFI_I1=3Dy<br>CONFIG_MTD_CFI_I2=3Dy<br># CONF=
IG_MTD_CFI_I4 is not set<br>
# CONFIG_MTD_CFI_I8 is not set<br>CONFIG_MTD_CFI_INTELEXT=3Dm<br>CONFIG_MTD=
_CFI_AMDSTD=3Dm<br>CONFIG_MTD_CFI_STAA=3Dm<br>CONFIG_MTD_CFI_UTIL=3Dm<br>CO=
NFIG_MTD_RAM=3Dm<br>CONFIG_MTD_ROM=3Dm<br>CONFIG_MTD_ABSENT=3Dm<br><br>#<br=
># Mapping drivers for chip access<br>
#<br>CONFIG_MTD_COMPLEX_MAPPINGS=3Dy<br># CONFIG_MTD_PHYSMAP is not set<br>=
CONFIG_MTD_SC520CDP=3Dm<br>CONFIG_MTD_NETSC520=3Dm<br>CONFIG_MTD_TS5500=3Dm=
<br># CONFIG_MTD_SBC_GXX is not set<br># CONFIG_MTD_AMD76XROM is not set<br=
># CONFIG_MTD_ICHXROM is not set<br>
CONFIG_MTD_ESB2ROM=3Dm<br>CONFIG_MTD_CK804XROM=3Dm<br>CONFIG_MTD_SCB2_FLASH=
=3Dm<br># CONFIG_MTD_NETtel is not set<br># CONFIG_MTD_L440GX is not set<br=
>CONFIG_MTD_PCI=3Dm<br># CONFIG_MTD_INTEL_VR_NOR is not set<br># CONFIG_MTD=
_PLATRAM is not set<br>
<br>#<br># Self-contained MTD device drivers<br>#<br>CONFIG_MTD_PMC551=3Dm<=
br># CONFIG_MTD_PMC551_BUGFIX is not set<br># CONFIG_MTD_PMC551_DEBUG is no=
t set<br># CONFIG_MTD_SLRAM is not set<br># CONFIG_MTD_PHRAM is not set<br>
CONFIG_MTD_MTDRAM=3Dm<br>CONFIG_MTDRAM_TOTAL_SIZE=3D4096<br>CONFIG_MTDRAM_E=
RASE_SIZE=3D128<br>CONFIG_MTD_BLOCK2MTD=3Dm<br><br>#<br># Disk-On-Chip Devi=
ce Drivers<br>#<br># CONFIG_MTD_DOC2000 is not set<br># CONFIG_MTD_DOC2001 =
is not set<br>
# CONFIG_MTD_DOC2001PLUS is not set<br>CONFIG_MTD_NAND=3Dm<br># CONFIG_MTD_=
NAND_VERIFY_WRITE is not set<br>CONFIG_MTD_NAND_ECC_SMC=3Dy<br># CONFIG_MTD=
_NAND_MUSEUM_IDS is not set<br>CONFIG_MTD_NAND_IDS=3Dm<br>CONFIG_MTD_NAND_D=
ISKONCHIP=3Dm<br>
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set<br>CONFIG_MTD_NAND_D=
ISKONCHIP_PROBE_ADDRESS=3D0<br># CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not=
 set<br># CONFIG_MTD_NAND_CAFE is not set<br>CONFIG_MTD_NAND_NANDSIM=3Dm<br=
>
# CONFIG_MTD_NAND_PLATFORM is not set<br>CONFIG_MTD_ALAUDA=3Dm<br># CONFIG_=
MTD_ONENAND is not set<br><br>#<br># LPDDR flash memory drivers<br>#<br>CON=
FIG_MTD_LPDDR=3Dm<br>CONFIG_MTD_QINFO_PROBE=3Dm<br><br>#<br># UBI - Unsorte=
d block images<br>
#<br>CONFIG_MTD_UBI=3Dm<br>CONFIG_MTD_UBI_WL_THRESHOLD=3D4096<br>CONFIG_MTD=
_UBI_BEB_RESERVE=3D1<br># CONFIG_MTD_UBI_GLUEBI is not set<br><br>#<br># UB=
I debugging options<br>#<br># CONFIG_MTD_UBI_DEBUG is not set<br>CONFIG_PAR=
PORT=3Dm<br>
CONFIG_PARPORT_PC=3Dm<br>CONFIG_PARPORT_SERIAL=3Dm<br># CONFIG_PARPORT_PC_F=
IFO is not set<br># CONFIG_PARPORT_PC_SUPERIO is not set<br>CONFIG_PARPORT_=
PC_PCMCIA=3Dm<br># CONFIG_PARPORT_GSC is not set<br># CONFIG_PARPORT_AX8879=
6 is not set<br>
CONFIG_PARPORT_1284=3Dy<br>CONFIG_PARPORT_NOT_PC=3Dy<br>CONFIG_PNP=3Dy<br>#=
 CONFIG_PNP_DEBUG_MESSAGES is not set<br><br>#<br># Protocols<br>#<br>CONFI=
G_PNPACPI=3Dy<br>CONFIG_BLK_DEV=3Dy<br>CONFIG_BLK_DEV_FD=3Dm<br>CONFIG_PARI=
DE=3Dm<br>
<br>#<br># Parallel IDE high-level drivers<br>#<br>CONFIG_PARIDE_PD=3Dm<br>=
CONFIG_PARIDE_PCD=3Dm<br>CONFIG_PARIDE_PF=3Dm<br>CONFIG_PARIDE_PT=3Dm<br>CO=
NFIG_PARIDE_PG=3Dm<br><br>#<br># Parallel IDE protocol modules<br>#<br>CONF=
IG_PARIDE_ATEN=3Dm<br>
CONFIG_PARIDE_BPCK=3Dm<br>CONFIG_PARIDE_COMM=3Dm<br>CONFIG_PARIDE_DSTR=3Dm<=
br>CONFIG_PARIDE_FIT2=3Dm<br>CONFIG_PARIDE_FIT3=3Dm<br>CONFIG_PARIDE_EPAT=
=3Dm<br>CONFIG_PARIDE_EPATC8=3Dy<br>CONFIG_PARIDE_EPIA=3Dm<br>CONFIG_PARIDE=
_FRIQ=3Dm<br>CONFIG_PARIDE_FRPW=3Dm<br>
CONFIG_PARIDE_KBIC=3Dm<br>CONFIG_PARIDE_KTTI=3Dm<br>CONFIG_PARIDE_ON20=3Dm<=
br>CONFIG_PARIDE_ON26=3Dm<br>CONFIG_BLK_CPQ_DA=3Dm<br>CONFIG_BLK_CPQ_CISS_D=
A=3Dm<br>CONFIG_CISS_SCSI_TAPE=3Dy<br>CONFIG_BLK_DEV_DAC960=3Dm<br>CONFIG_B=
LK_DEV_UMEM=3Dm<br>
# CONFIG_BLK_DEV_COW_COMMON is not set<br>CONFIG_BLK_DEV_LOOP=3Dy<br>CONFIG=
_BLK_DEV_CRYPTOLOOP=3Dm<br># CONFIG_BLK_DEV_DRBD is not set<br>CONFIG_BLK_D=
EV_NBD=3Dm<br>CONFIG_BLK_DEV_SX8=3Dm<br># CONFIG_BLK_DEV_UB is not set<br>C=
ONFIG_BLK_DEV_RAM=3Dy<br>
CONFIG_BLK_DEV_RAM_COUNT=3D16<br>CONFIG_BLK_DEV_RAM_SIZE=3D16384<br># CONFI=
G_BLK_DEV_XIP is not set<br>CONFIG_CDROM_PKTCDVD=3Dm<br>CONFIG_CDROM_PKTCDV=
D_BUFFERS=3D8<br># CONFIG_CDROM_PKTCDVD_WCACHE is not set<br>CONFIG_ATA_OVE=
R_ETH=3Dm<br>
# CONFIG_BLK_DEV_HD is not set<br>CONFIG_MISC_DEVICES=3Dy<br># CONFIG_AD525=
X_DPOT is not set<br># CONFIG_IBM_ASM is not set<br># CONFIG_PHANTOM is not=
 set<br>CONFIG_SGI_IOC4=3Dm<br>CONFIG_TIFM_CORE=3Dm<br>CONFIG_TIFM_7XX1=3Dm=
<br>
CONFIG_ICS932S401=3Dm<br>CONFIG_ENCLOSURE_SERVICES=3Dm<br># CONFIG_CS5535_M=
FGPT is not set<br># CONFIG_HP_ILO is not set<br># CONFIG_ISL29003 is not s=
et<br>CONFIG_SENSORS_TSL2550=3Dm<br># CONFIG_DS1682 is not set<br># CONFIG_=
VMWARE_BALLOON is not set<br>
# CONFIG_C2PORT is not set<br><br>#<br># EEPROM support<br>#<br>CONFIG_EEPR=
OM_AT24=3Dm<br>CONFIG_EEPROM_LEGACY=3Dm<br># CONFIG_EEPROM_MAX6875 is not s=
et<br>CONFIG_EEPROM_93CX6=3Dm<br># CONFIG_CB710_CORE is not set<br># CONFIG=
_IWMC3200TOP is not set<br>
CONFIG_HAVE_IDE=3Dy<br># CONFIG_IDE is not set<br><br>#<br># SCSI device su=
pport<br>#<br>CONFIG_SCSI_MOD=3Dy<br>CONFIG_RAID_ATTRS=3Dm<br>CONFIG_SCSI=
=3Dy<br>CONFIG_SCSI_DMA=3Dy<br>CONFIG_SCSI_TGT=3Dm<br>CONFIG_SCSI_NETLINK=
=3Dy<br>CONFIG_SCSI_PROC_FS=3Dy<br>
<br>#<br># SCSI support type (disk, tape, CD-ROM)<br>#<br>CONFIG_BLK_DEV_SD=
=3Dy<br>CONFIG_CHR_DEV_ST=3Dm<br>CONFIG_CHR_DEV_OSST=3Dm<br>CONFIG_BLK_DEV_=
SR=3Dy<br>CONFIG_BLK_DEV_SR_VENDOR=3Dy<br>CONFIG_CHR_DEV_SG=3Dy<br>CONFIG_C=
HR_DEV_SCH=3Dm<br>
CONFIG_SCSI_ENCLOSURE=3Dm<br>CONFIG_SCSI_MULTI_LUN=3Dy<br>CONFIG_SCSI_CONST=
ANTS=3Dy<br>CONFIG_SCSI_LOGGING=3Dy<br>CONFIG_SCSI_SCAN_ASYNC=3Dy<br>CONFIG=
_SCSI_WAIT_SCAN=3Dm<br><br>#<br># SCSI Transports<br>#<br>CONFIG_SCSI_SPI_A=
TTRS=3Dm<br>
CONFIG_SCSI_FC_ATTRS=3Dm<br>CONFIG_SCSI_FC_TGT_ATTRS=3Dy<br>CONFIG_SCSI_ISC=
SI_ATTRS=3Dm<br>CONFIG_SCSI_SAS_ATTRS=3Dm<br>CONFIG_SCSI_SAS_LIBSAS=3Dm<br>=
CONFIG_SCSI_SAS_ATA=3Dy<br>CONFIG_SCSI_SAS_HOST_SMP=3Dy<br># CONFIG_SCSI_SA=
S_LIBSAS_DEBUG is not set<br>
CONFIG_SCSI_SRP_ATTRS=3Dm<br>CONFIG_SCSI_SRP_TGT_ATTRS=3Dy<br>CONFIG_SCSI_L=
OWLEVEL=3Dy<br>CONFIG_ISCSI_TCP=3Dm<br>CONFIG_SCSI_CXGB3_ISCSI=3Dm<br># CON=
FIG_SCSI_BNX2_ISCSI is not set<br># CONFIG_BE2ISCSI is not set<br>CONFIG_BL=
K_DEV_3W_XXXX_RAID=3Dm<br>
# CONFIG_SCSI_HPSA is not set<br>CONFIG_SCSI_3W_9XXX=3Dm<br># CONFIG_SCSI_3=
W_SAS is not set<br>CONFIG_SCSI_ACARD=3Dm<br>CONFIG_SCSI_AACRAID=3Dm<br>CON=
FIG_SCSI_AIC7XXX=3Dm<br>CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D4<br>CONFIG_AIC7XX=
X_RESET_DELAY_MS=3D15000<br>
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set<br>CONFIG_AIC7XXX_DEBUG_MASK=3D0<b=
r># CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set<br>CONFIG_SCSI_AIC7XXX_OLD=
=3Dm<br>CONFIG_SCSI_AIC79XX=3Dm<br>CONFIG_AIC79XX_CMDS_PER_DEVICE=3D4<br>CO=
NFIG_AIC79XX_RESET_DELAY_MS=3D15000<br>
# CONFIG_AIC79XX_DEBUG_ENABLE is not set<br>CONFIG_AIC79XX_DEBUG_MASK=3D0<b=
r># CONFIG_AIC79XX_REG_PRETTY_PRINT is not set<br>CONFIG_SCSI_AIC94XX=3Dm<b=
r># CONFIG_AIC94XX_DEBUG is not set<br>CONFIG_SCSI_MVSAS=3Dm<br>CONFIG_SCSI=
_MVSAS_DEBUG=3Dy<br>
# CONFIG_SCSI_DPT_I2O is not set<br># CONFIG_SCSI_ADVANSYS is not set<br>CO=
NFIG_SCSI_ARCMSR=3Dm<br>CONFIG_SCSI_ARCMSR_AER=3Dy<br>CONFIG_MEGARAID_NEWGE=
N=3Dy<br>CONFIG_MEGARAID_MM=3Dm<br>CONFIG_MEGARAID_MAILBOX=3Dm<br>CONFIG_ME=
GARAID_LEGACY=3Dm<br>
CONFIG_MEGARAID_SAS=3Dm<br># CONFIG_SCSI_MPT2SAS is not set<br>CONFIG_SCSI_=
HPTIOP=3Dm<br>CONFIG_SCSI_BUSLOGIC=3Dm<br># CONFIG_VMWARE_PVSCSI is not set=
<br>CONFIG_LIBFC=3Dm<br>CONFIG_LIBFCOE=3Dm<br>CONFIG_FCOE=3Dm<br># CONFIG_F=
COE_FNIC is not set<br>
# CONFIG_SCSI_DMX3191D is not set<br># CONFIG_SCSI_EATA is not set<br># CON=
FIG_SCSI_FUTURE_DOMAIN is not set<br>CONFIG_SCSI_GDTH=3Dm<br>CONFIG_SCSI_IP=
S=3Dm<br>CONFIG_SCSI_INITIO=3Dm<br>CONFIG_SCSI_INIA100=3Dm<br>CONFIG_SCSI_P=
PA=3Dm<br>
CONFIG_SCSI_IMM=3Dm<br># CONFIG_SCSI_IZIP_EPP16 is not set<br># CONFIG_SCSI=
_IZIP_SLOW_CTR is not set<br>CONFIG_SCSI_STEX=3Dm<br>CONFIG_SCSI_SYM53C8XX_=
2=3Dm<br>CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1<br>CONFIG_SCSI_SYM53=
C8XX_DEFAULT_TAGS=3D16<br>
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64<br>CONFIG_SCSI_SYM53C8XX_MMIO=3Dy<br># =
CONFIG_SCSI_IPR is not set<br>CONFIG_SCSI_QLOGIC_1280=3Dm<br>CONFIG_SCSI_QL=
A_FC=3Dm<br>CONFIG_SCSI_QLA_ISCSI=3Dm<br>CONFIG_SCSI_LPFC=3Dm<br># CONFIG_S=
CSI_LPFC_DEBUG_FS is not set<br>
CONFIG_SCSI_DC395x=3Dm<br>CONFIG_SCSI_DC390T=3Dm<br># CONFIG_SCSI_DEBUG is =
not set<br># CONFIG_SCSI_PMCRAID is not set<br># CONFIG_SCSI_PM8001 is not =
set<br>CONFIG_SCSI_SRP=3Dm<br># CONFIG_SCSI_BFA_FC is not set<br>CONFIG_SCS=
I_LOWLEVEL_PCMCIA=3Dy<br>
# CONFIG_PCMCIA_FDOMAIN is not set<br>CONFIG_PCMCIA_QLOGIC=3Dm<br>CONFIG_PC=
MCIA_SYM53C500=3Dm<br>CONFIG_SCSI_DH=3Dy<br>CONFIG_SCSI_DH_RDAC=3Dm<br>CONF=
IG_SCSI_DH_HP_SW=3Dm<br>CONFIG_SCSI_DH_EMC=3Dm<br>CONFIG_SCSI_DH_ALUA=3Dm<b=
r># CONFIG_SCSI_OSD_INITIATOR is not set<br>
CONFIG_ATA=3Dy<br># CONFIG_ATA_NONSTANDARD is not set<br>CONFIG_ATA_VERBOSE=
_ERROR=3Dy<br>CONFIG_ATA_ACPI=3Dy<br>CONFIG_SATA_PMP=3Dy<br>CONFIG_SATA_AHC=
I=3Dy<br>CONFIG_SATA_SIL24=3Dm<br>CONFIG_ATA_SFF=3Dy<br>CONFIG_SATA_SVW=3Dm=
<br>CONFIG_ATA_PIIX=3Dy<br>
CONFIG_SATA_MV=3Dm<br>CONFIG_SATA_NV=3Dm<br>CONFIG_PDC_ADMA=3Dm<br>CONFIG_S=
ATA_QSTOR=3Dm<br>CONFIG_SATA_PROMISE=3Dm<br>CONFIG_SATA_SX4=3Dm<br>CONFIG_S=
ATA_SIL=3Dm<br>CONFIG_SATA_SIS=3Dm<br>CONFIG_SATA_ULI=3Dm<br>CONFIG_SATA_VI=
A=3Dm<br>CONFIG_SATA_VITESSE=3Dm<br>
CONFIG_SATA_INIC162X=3Dm<br>CONFIG_PATA_ACPI=3Dm<br>CONFIG_PATA_ALI=3Dm<br>=
CONFIG_PATA_AMD=3Dm<br>CONFIG_PATA_ARTOP=3Dm<br># CONFIG_PATA_ATP867X is no=
t set<br>CONFIG_PATA_ATIIXP=3Dm<br>CONFIG_PATA_CMD640_PCI=3Dm<br>CONFIG_PAT=
A_CMD64X=3Dm<br>
CONFIG_PATA_CS5520=3Dm<br>CONFIG_PATA_CS5530=3Dm<br>CONFIG_PATA_CYPRESS=3Dm=
<br>CONFIG_PATA_EFAR=3Dm<br>CONFIG_ATA_GENERIC=3Dm<br>CONFIG_PATA_HPT366=3D=
m<br>CONFIG_PATA_HPT37X=3Dm<br>CONFIG_PATA_HPT3X2N=3Dm<br>CONFIG_PATA_HPT3X=
3=3Dm<br># CONFIG_PATA_HPT3X3_DMA is not set<br>
CONFIG_PATA_IT821X=3Dm<br>CONFIG_PATA_IT8213=3Dm<br>CONFIG_PATA_JMICRON=3Dm=
<br># CONFIG_PATA_LEGACY is not set<br>CONFIG_PATA_TRIFLEX=3Dm<br>CONFIG_PA=
TA_MARVELL=3Dm<br>CONFIG_PATA_MPIIX=3Dm<br>CONFIG_PATA_OLDPIIX=3Dm<br>CONFI=
G_PATA_NETCELL=3Dm<br>
CONFIG_PATA_NINJA32=3Dm<br>CONFIG_PATA_NS87410=3Dm<br>CONFIG_PATA_NS87415=
=3Dm<br>CONFIG_PATA_OPTI=3Dm<br>CONFIG_PATA_OPTIDMA=3Dm<br>CONFIG_PATA_PCMC=
IA=3Dm<br>CONFIG_PATA_PDC2027X=3Dm<br>CONFIG_PATA_PDC_OLD=3Dm<br># CONFIG_P=
ATA_RADISYS is not set<br>
# CONFIG_PATA_RDC is not set<br># CONFIG_PATA_RZ1000 is not set<br># CONFIG=
_PATA_SC1200 is not set<br>CONFIG_PATA_SERVERWORKS=3Dm<br>CONFIG_PATA_SIL68=
0=3Dm<br>CONFIG_PATA_SIS=3Dm<br># CONFIG_PATA_TOSHIBA is not set<br>CONFIG_=
PATA_VIA=3Dm<br>
CONFIG_PATA_WINBOND=3Dm<br>CONFIG_PATA_SCH=3Dm<br>CONFIG_MD=3Dy<br>CONFIG_B=
LK_DEV_MD=3Dy<br>CONFIG_MD_AUTODETECT=3Dy<br>CONFIG_MD_LINEAR=3Dm<br>CONFIG=
_MD_RAID0=3Dm<br>CONFIG_MD_RAID1=3Dm<br>CONFIG_MD_RAID10=3Dm<br>CONFIG_MD_R=
AID456=3Dm<br># CONFIG_MULTICORE_RAID456 is not set<br>
CONFIG_MD_RAID6_PQ=3Dm<br># CONFIG_ASYNC_RAID6_TEST is not set<br>CONFIG_MD=
_MULTIPATH=3Dm<br>CONFIG_MD_FAULTY=3Dm<br>CONFIG_BLK_DEV_DM=3Dy<br>CONFIG_D=
M_DEBUG=3Dy<br>CONFIG_DM_CRYPT=3Dm<br>CONFIG_DM_SNAPSHOT=3Dy<br>CONFIG_DM_M=
IRROR=3Dy<br>
# CONFIG_DM_LOG_USERSPACE is not set<br>CONFIG_DM_ZERO=3Dy<br>CONFIG_DM_MUL=
TIPATH=3Dm<br># CONFIG_DM_MULTIPATH_QL is not set<br># CONFIG_DM_MULTIPATH_=
ST is not set<br># CONFIG_DM_DELAY is not set<br>CONFIG_DM_UEVENT=3Dy<br>CO=
NFIG_FUSION=3Dy<br>
CONFIG_FUSION_SPI=3Dm<br>CONFIG_FUSION_FC=3Dm<br>CONFIG_FUSION_SAS=3Dm<br>C=
ONFIG_FUSION_MAX_SGE=3D40<br>CONFIG_FUSION_CTL=3Dm<br>CONFIG_FUSION_LAN=3Dm=
<br>CONFIG_FUSION_LOGGING=3Dy<br><br>#<br># IEEE 1394 (FireWire) support<br=
>#<br><br>
#<br># You can enable one or both FireWire driver stacks.<br>#<br><br>#<br>=
# The newer stack is recommended.<br>#<br>CONFIG_FIREWIRE=3Dm<br>CONFIG_FIR=
EWIRE_OHCI=3Dm<br>CONFIG_FIREWIRE_OHCI_DEBUG=3Dy<br>CONFIG_FIREWIRE_SBP2=3D=
m<br>
# CONFIG_FIREWIRE_NET is not set<br># CONFIG_IEEE1394 is not set<br>CONFIG_=
I2O=3Dm<br># CONFIG_I2O_LCT_NOTIFY_ON_CHANGES is not set<br>CONFIG_I2O_EXT_=
ADAPTEC=3Dy<br>CONFIG_I2O_EXT_ADAPTEC_DMA64=3Dy<br>CONFIG_I2O_CONFIG=3Dm<br=
>CONFIG_I2O_CONFIG_OLD_IOCTL=3Dy<br>
CONFIG_I2O_BUS=3Dm<br>CONFIG_I2O_BLOCK=3Dm<br>CONFIG_I2O_SCSI=3Dm<br>CONFIG=
_I2O_PROC=3Dm<br>CONFIG_MACINTOSH_DRIVERS=3Dy<br>CONFIG_MAC_EMUMOUSEBTN=3Dy=
<br>CONFIG_NETDEVICES=3Dy<br>CONFIG_IFB=3Dm<br>CONFIG_DUMMY=3Dm<br>CONFIG_B=
ONDING=3Dm<br>CONFIG_MACVLAN=3Dm<br>
# CONFIG_MACVTAP is not set<br>CONFIG_EQUALIZER=3Dm<br>CONFIG_TUN=3Dm<br>CO=
NFIG_VETH=3Dm<br>CONFIG_NET_SB1000=3Dm<br># CONFIG_ARCNET is not set<br>CON=
FIG_PHYLIB=3Dy<br><br>#<br># MII PHY device drivers<br>#<br>CONFIG_MARVELL_=
PHY=3Dm<br>
CONFIG_DAVICOM_PHY=3Dm<br>CONFIG_QSEMI_PHY=3Dm<br>CONFIG_LXT_PHY=3Dm<br>CON=
FIG_CICADA_PHY=3Dm<br>CONFIG_VITESSE_PHY=3Dm<br>CONFIG_SMSC_PHY=3Dm<br>CONF=
IG_BROADCOM_PHY=3Dm<br>CONFIG_ICPLUS_PHY=3Dm<br>CONFIG_REALTEK_PHY=3Dm<br>C=
ONFIG_NATIONAL_PHY=3Dm<br>
CONFIG_STE10XP=3Dm<br>CONFIG_LSI_ET1011C_PHY=3Dm<br># CONFIG_MICREL_PHY is =
not set<br>CONFIG_FIXED_PHY=3Dy<br>CONFIG_MDIO_BITBANG=3Dm<br>CONFIG_NET_ET=
HERNET=3Dy<br>CONFIG_MII=3Dm<br>CONFIG_HAPPYMEAL=3Dm<br>CONFIG_SUNGEM=3Dm<b=
r>CONFIG_CASSINI=3Dm<br>
CONFIG_NET_VENDOR_3COM=3Dy<br>CONFIG_VORTEX=3Dm<br>CONFIG_TYPHOON=3Dm<br># =
CONFIG_ETHOC is not set<br>CONFIG_DNET=3Dm<br>CONFIG_NET_TULIP=3Dy<br>CONFI=
G_DE2104X=3Dm<br>CONFIG_DE2104X_DSL=3D0<br>CONFIG_TULIP=3Dm<br># CONFIG_TUL=
IP_MWI is not set<br>
CONFIG_TULIP_MMIO=3Dy<br># CONFIG_TULIP_NAPI is not set<br>CONFIG_DE4X5=3Dm=
<br>CONFIG_WINBOND_840=3Dm<br>CONFIG_DM9102=3Dm<br>CONFIG_ULI526X=3Dm<br>CO=
NFIG_PCMCIA_XIRCOM=3Dm<br># CONFIG_HP100 is not set<br># CONFIG_IBM_NEW_EMA=
C_ZMII is not set<br>
# CONFIG_IBM_NEW_EMAC_RGMII is not set<br># CONFIG_IBM_NEW_EMAC_TAH is not =
set<br># CONFIG_IBM_NEW_EMAC_EMAC4 is not set<br># CONFIG_IBM_NEW_EMAC_NO_F=
LOW_CTRL is not set<br># CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set<b=
r>
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set<br>CONFIG_NET_PCI=3Dy<br>CO=
NFIG_PCNET32=3Dm<br>CONFIG_AMD8111_ETH=3Dm<br>CONFIG_ADAPTEC_STARFIRE=3Dm<b=
r># CONFIG_KSZ884X_PCI is not set<br>CONFIG_B44=3Dm<br>CONFIG_B44_PCI_AUTOS=
ELECT=3Dy<br>
CONFIG_B44_PCICORE_AUTOSELECT=3Dy<br>CONFIG_B44_PCI=3Dy<br>CONFIG_FORCEDETH=
=3Dm<br>CONFIG_FORCEDETH_NAPI=3Dy<br>CONFIG_E100=3Dm<br>CONFIG_FEALNX=3Dm<b=
r>CONFIG_NATSEMI=3Dm<br>CONFIG_NE2K_PCI=3Dm<br>CONFIG_8139CP=3Dm<br>CONFIG_=
8139TOO=3Dm<br># CONFIG_8139TOO_PIO is not set<br>
# CONFIG_8139TOO_TUNE_TWISTER is not set<br>CONFIG_8139TOO_8129=3Dy<br># CO=
NFIG_8139_OLD_RX_RESET is not set<br>CONFIG_R6040=3Dm<br>CONFIG_SIS900=3Dm<=
br>CONFIG_EPIC100=3Dm<br>CONFIG_SMSC9420=3Dm<br>CONFIG_SUNDANCE=3Dm<br># CO=
NFIG_SUNDANCE_MMIO is not set<br>
CONFIG_TLAN=3Dm<br># CONFIG_KS8842 is not set<br># CONFIG_KS8851_MLL is not=
 set<br>CONFIG_VIA_RHINE=3Dm<br>CONFIG_VIA_RHINE_MMIO=3Dy<br>CONFIG_SC92031=
=3Dm<br>CONFIG_NET_POCKET=3Dy<br>CONFIG_ATP=3Dm<br>CONFIG_DE600=3Dm<br>CONF=
IG_DE620=3Dm<br>
CONFIG_ATL2=3Dm<br>CONFIG_NETDEV_1000=3Dy<br>CONFIG_ACENIC=3Dm<br># CONFIG_=
ACENIC_OMIT_TIGON_I is not set<br>CONFIG_DL2K=3Dm<br>CONFIG_E1000=3Dm<br>CO=
NFIG_E1000E=3Dm<br>CONFIG_IP1000=3Dm<br>CONFIG_IGB=3Dm<br>CONFIG_IGB_DCA=3D=
y<br># CONFIG_IGBVF is not set<br>
CONFIG_NS83820=3Dm<br>CONFIG_HAMACHI=3Dm<br>CONFIG_YELLOWFIN=3Dm<br>CONFIG_=
R8169=3Dm<br>CONFIG_R8169_VLAN=3Dy<br>CONFIG_SIS190=3Dm<br>CONFIG_SKGE=3Dm<=
br># CONFIG_SKGE_DEBUG is not set<br>CONFIG_SKY2=3Dm<br># CONFIG_SKY2_DEBUG=
 is not set<br>
CONFIG_VIA_VELOCITY=3Dm<br>CONFIG_TIGON3=3Dm<br>CONFIG_BNX2=3Dm<br># CONFIG=
_CNIC is not set<br>CONFIG_QLA3XXX=3Dm<br>CONFIG_ATL1=3Dm<br>CONFIG_ATL1E=
=3Dm<br>CONFIG_ATL1C=3Dm<br>CONFIG_JME=3Dm<br>CONFIG_NETDEV_10000=3Dy<br>CO=
NFIG_MDIO=3Dm<br>CONFIG_CHELSIO_T1=3Dm<br>
CONFIG_CHELSIO_T1_1G=3Dy<br>CONFIG_CHELSIO_T3_DEPENDS=3Dy<br>CONFIG_CHELSIO=
_T3=3Dm<br>CONFIG_CHELSIO_T4_DEPENDS=3Dy<br># CONFIG_CHELSIO_T4 is not set<=
br>CONFIG_ENIC=3Dm<br>CONFIG_IXGBE=3Dm<br>CONFIG_IXGBE_DCA=3Dy<br>CONFIG_IX=
GBE_DCB=3Dy<br>
# CONFIG_IXGBEVF is not set<br>CONFIG_IXGB=3Dm<br>CONFIG_S2IO=3Dm<br># CONF=
IG_VXGE is not set<br>CONFIG_MYRI10GE=3Dm<br>CONFIG_MYRI10GE_DCA=3Dy<br>CON=
FIG_NETXEN_NIC=3Dm<br>CONFIG_NIU=3Dm<br>CONFIG_MLX4_EN=3Dm<br>CONFIG_MLX4_C=
ORE=3Dm<br>CONFIG_MLX4_DEBUG=3Dy<br>
CONFIG_TEHUTI=3Dm<br>CONFIG_BNX2X=3Dm<br># CONFIG_QLCNIC is not set<br>CONF=
IG_QLGE=3Dm<br>CONFIG_SFC=3Dm<br>CONFIG_SFC_MTD=3Dy<br>CONFIG_BE2NET=3Dm<br=
># CONFIG_TR is not set<br>CONFIG_WLAN=3Dy<br># CONFIG_PCMCIA_RAYCS is not =
set<br>CONFIG_LIBERTAS_THINFIRM=3Dm<br>
CONFIG_LIBERTAS_THINFIRM_USB=3Dm<br>CONFIG_AIRO=3Dm<br>CONFIG_ATMEL=3Dm<br>=
CONFIG_PCI_ATMEL=3Dm<br>CONFIG_PCMCIA_ATMEL=3Dm<br># CONFIG_AT76C50X_USB is=
 not set<br>CONFIG_AIRO_CS=3Dm<br>CONFIG_PCMCIA_WL3501=3Dm<br>CONFIG_PRISM5=
4=3Dm<br>CONFIG_USB_ZD1201=3Dm<br>
CONFIG_USB_NET_RNDIS_WLAN=3Dm<br>CONFIG_RTL8180=3Dm<br>CONFIG_RTL8187=3Dm<b=
r>CONFIG_RTL8187_LEDS=3Dy<br>CONFIG_ADM8211=3Dm<br>CONFIG_MAC80211_HWSIM=3D=
m<br># CONFIG_MWL8K is not set<br># CONFIG_ATH_COMMON is not set<br>CONFIG_=
B43=3Dm<br>
CONFIG_B43_PCI_AUTOSELECT=3Dy<br>CONFIG_B43_PCICORE_AUTOSELECT=3Dy<br>CONFI=
G_B43_PCMCIA=3Dy<br># CONFIG_B43_SDIO is not set<br>CONFIG_B43_PIO=3Dy<br>C=
ONFIG_B43_PHY_LP=3Dy<br>CONFIG_B43_LEDS=3Dy<br>CONFIG_B43_HWRNG=3Dy<br># CO=
NFIG_B43_DEBUG is not set<br>
CONFIG_B43LEGACY=3Dm<br>CONFIG_B43LEGACY_PCI_AUTOSELECT=3Dy<br>CONFIG_B43LE=
GACY_PCICORE_AUTOSELECT=3Dy<br>CONFIG_B43LEGACY_LEDS=3Dy<br>CONFIG_B43LEGAC=
Y_HWRNG=3Dy<br># CONFIG_B43LEGACY_DEBUG is not set<br>CONFIG_B43LEGACY_DMA=
=3Dy<br>CONFIG_B43LEGACY_PIO=3Dy<br>
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy<br># CONFIG_B43LEGACY_DMA_MODE is not=
 set<br># CONFIG_B43LEGACY_PIO_MODE is not set<br>CONFIG_HOSTAP=3Dm<br>CONF=
IG_HOSTAP_FIRMWARE=3Dy<br>CONFIG_HOSTAP_FIRMWARE_NVRAM=3Dy<br>CONFIG_HOSTAP=
_PLX=3Dm<br>
CONFIG_HOSTAP_PCI=3Dm<br>CONFIG_HOSTAP_CS=3Dm<br>CONFIG_IPW2100=3Dm<br>CONF=
IG_IPW2100_MONITOR=3Dy<br># CONFIG_IPW2100_DEBUG is not set<br>CONFIG_IPW22=
00=3Dm<br>CONFIG_IPW2200_MONITOR=3Dy<br>CONFIG_IPW2200_RADIOTAP=3Dy<br>CONF=
IG_IPW2200_PROMISCUOUS=3Dy<br>
CONFIG_IPW2200_QOS=3Dy<br># CONFIG_IPW2200_DEBUG is not set<br>CONFIG_LIBIP=
W=3Dm<br># CONFIG_LIBIPW_DEBUG is not set<br>CONFIG_IWLWIFI=3Dm<br>CONFIG_I=
WLWIFI_DEBUG=3Dy<br>CONFIG_IWLWIFI_DEBUGFS=3Dy<br># CONFIG_IWLWIFI_DEVICE_T=
RACING is not set<br>
CONFIG_IWLAGN=3Dm<br>CONFIG_IWL4965=3Dy<br>CONFIG_IWL5000=3Dy<br>CONFIG_IWL=
3945=3Dm<br># CONFIG_IWM is not set<br>CONFIG_LIBERTAS=3Dm<br>CONFIG_LIBERT=
AS_USB=3Dm<br>CONFIG_LIBERTAS_CS=3Dm<br>CONFIG_LIBERTAS_SDIO=3Dm<br>CONFIG_=
LIBERTAS_DEBUG=3Dy<br>
# CONFIG_LIBERTAS_MESH is not set<br>CONFIG_HERMES=3Dm<br>CONFIG_HERMES_CAC=
HE_FW_ON_INIT=3Dy<br>CONFIG_PLX_HERMES=3Dm<br>CONFIG_TMD_HERMES=3Dm<br>CONF=
IG_NORTEL_HERMES=3Dm<br>CONFIG_PCI_HERMES=3Dm<br>CONFIG_PCMCIA_HERMES=3Dm<b=
r>CONFIG_PCMCIA_SPECTRUM=3Dm<br>
CONFIG_P54_COMMON=3Dm<br>CONFIG_P54_USB=3Dm<br>CONFIG_P54_PCI=3Dm<br>CONFIG=
_P54_LEDS=3Dy<br>CONFIG_RT2X00=3Dm<br>CONFIG_RT2400PCI=3Dm<br>CONFIG_RT2500=
PCI=3Dm<br>CONFIG_RT61PCI=3Dm<br>CONFIG_RT2800PCI_PCI=3Dy<br># CONFIG_RT280=
0PCI is not set<br>
CONFIG_RT2500USB=3Dm<br>CONFIG_RT73USB=3Dm<br># CONFIG_RT2800USB is not set=
<br>CONFIG_RT2X00_LIB_PCI=3Dm<br>CONFIG_RT2X00_LIB_USB=3Dm<br>CONFIG_RT2X00=
_LIB=3Dm<br>CONFIG_RT2X00_LIB_FIRMWARE=3Dy<br>CONFIG_RT2X00_LIB_CRYPTO=3Dy<=
br>CONFIG_RT2X00_LIB_LEDS=3Dy<br>
CONFIG_RT2X00_LIB_DEBUGFS=3Dy<br># CONFIG_RT2X00_DEBUG is not set<br># CONF=
IG_WL12XX is not set<br>CONFIG_ZD1211RW=3Dm<br># CONFIG_ZD1211RW_DEBUG is n=
ot set<br><br>#<br># WiMAX Wireless Broadband devices<br>#<br>CONFIG_WIMAX_=
I2400M=3Dm<br>
CONFIG_WIMAX_I2400M_USB=3Dm<br>CONFIG_WIMAX_I2400M_SDIO=3Dm<br># CONFIG_WIM=
AX_IWMC3200_SDIO is not set<br>CONFIG_WIMAX_I2400M_DEBUG_LEVEL=3D8<br><br>#=
<br># USB Network Adapters<br>#<br>CONFIG_USB_CATC=3Dm<br>CONFIG_USB_KAWETH=
=3Dm<br>
CONFIG_USB_PEGASUS=3Dm<br>CONFIG_USB_RTL8150=3Dm<br>CONFIG_USB_USBNET=3Dm<b=
r>CONFIG_USB_NET_AX8817X=3Dm<br>CONFIG_USB_NET_CDCETHER=3Dm<br># CONFIG_USB=
_NET_CDC_EEM is not set<br>CONFIG_USB_NET_DM9601=3Dm<br># CONFIG_USB_NET_SM=
SC75XX is not set<br>
CONFIG_USB_NET_SMSC95XX=3Dm<br>CONFIG_USB_NET_GL620A=3Dm<br>CONFIG_USB_NET_=
NET1080=3Dm<br>CONFIG_USB_NET_PLUSB=3Dm<br>CONFIG_USB_NET_MCS7830=3Dm<br>CO=
NFIG_USB_NET_RNDIS_HOST=3Dm<br>CONFIG_USB_NET_CDC_SUBSET=3Dm<br>CONFIG_USB_=
ALI_M5632=3Dy<br>
CONFIG_USB_AN2720=3Dy<br>CONFIG_USB_BELKIN=3Dy<br>CONFIG_USB_ARMLINUX=3Dy<b=
r>CONFIG_USB_EPSON2888=3Dy<br>CONFIG_USB_KC2190=3Dy<br>CONFIG_USB_NET_ZAURU=
S=3Dm<br>CONFIG_USB_HSO=3Dm<br># CONFIG_USB_NET_INT51X1 is not set<br># CON=
FIG_USB_CDC_PHONET is not set<br>
# CONFIG_USB_IPHETH is not set<br># CONFIG_USB_SIERRA_NET is not set<br>CON=
FIG_NET_PCMCIA=3Dy<br>CONFIG_PCMCIA_3C589=3Dm<br>CONFIG_PCMCIA_3C574=3Dm<br=
>CONFIG_PCMCIA_FMVJ18X=3Dm<br>CONFIG_PCMCIA_PCNET=3Dm<br>CONFIG_PCMCIA_NMCL=
AN=3Dm<br>
CONFIG_PCMCIA_SMC91C92=3Dm<br>CONFIG_PCMCIA_XIRC2PS=3Dm<br>CONFIG_PCMCIA_AX=
NET=3Dm<br># CONFIG_WAN is not set<br>CONFIG_ATM_DRIVERS=3Dy<br># CONFIG_AT=
M_DUMMY is not set<br>CONFIG_ATM_TCP=3Dm<br># CONFIG_ATM_LANAI is not set<b=
r>CONFIG_ATM_ENI=3Dm<br>
# CONFIG_ATM_ENI_DEBUG is not set<br># CONFIG_ATM_ENI_TUNE_BURST is not set=
<br>CONFIG_ATM_FIRESTREAM=3Dm<br># CONFIG_ATM_ZATM is not set<br># CONFIG_A=
TM_IDT77252 is not set<br># CONFIG_ATM_AMBASSADOR is not set<br># CONFIG_AT=
M_HORIZON is not set<br>
# CONFIG_ATM_IA is not set<br># CONFIG_ATM_FORE200E is not set<br># CONFIG_=
ATM_HE is not set<br># CONFIG_ATM_SOLOS is not set<br>CONFIG_FDDI=3Dy<br># =
CONFIG_DEFXX is not set<br>CONFIG_SKFP=3Dm<br># CONFIG_HIPPI is not set<br>
CONFIG_PLIP=3Dm<br>CONFIG_PPP=3Dm<br>CONFIG_PPP_MULTILINK=3Dy<br>CONFIG_PPP=
_FILTER=3Dy<br>CONFIG_PPP_ASYNC=3Dm<br>CONFIG_PPP_SYNC_TTY=3Dm<br>CONFIG_PP=
P_DEFLATE=3Dm<br># CONFIG_PPP_BSDCOMP is not set<br>CONFIG_PPP_MPPE=3Dm<br>=
CONFIG_PPPOE=3Dm<br>
CONFIG_PPPOATM=3Dm<br>CONFIG_PPPOL2TP=3Dm<br>CONFIG_SLIP=3Dm<br>CONFIG_SLIP=
_COMPRESSED=3Dy<br>CONFIG_SLHC=3Dm<br>CONFIG_SLIP_SMART=3Dy<br># CONFIG_SLI=
P_MODE_SLIP6 is not set<br>CONFIG_NET_FC=3Dy<br>CONFIG_NETCONSOLE=3Dm<br>CO=
NFIG_NETCONSOLE_DYNAMIC=3Dy<br>
CONFIG_NETPOLL=3Dy<br>CONFIG_NETPOLL_TRAP=3Dy<br>CONFIG_NET_POLL_CONTROLLER=
=3Dy<br># CONFIG_VMXNET3 is not set<br>CONFIG_ISDN=3Dy<br>CONFIG_ISDN_I4L=
=3Dm<br>CONFIG_ISDN_PPP=3Dy<br>CONFIG_ISDN_PPP_VJ=3Dy<br>CONFIG_ISDN_MPP=3D=
y<br>CONFIG_IPPP_FILTER=3Dy<br>
# CONFIG_ISDN_PPP_BSDCOMP is not set<br>CONFIG_ISDN_AUDIO=3Dy<br>CONFIG_ISD=
N_TTY_FAX=3Dy<br><br>#<br># ISDN feature submodules<br>#<br>CONFIG_ISDN_DIV=
ERSION=3Dm<br><br>#<br># ISDN4Linux hardware drivers<br>#<br><br>#<br># Pas=
sive cards<br>
#<br>CONFIG_ISDN_DRV_HISAX=3Dm<br><br>#<br># D-channel protocol features<br=
>#<br>CONFIG_HISAX_EURO=3Dy<br>CONFIG_DE_AOC=3Dy<br>CONFIG_HISAX_NO_SENDCOM=
PLETE=3Dy<br>CONFIG_HISAX_NO_LLC=3Dy<br>CONFIG_HISAX_NO_KEYPAD=3Dy<br>CONFI=
G_HISAX_1TR6=3Dy<br>
CONFIG_HISAX_NI1=3Dy<br>CONFIG_HISAX_MAX_CARDS=3D8<br><br>#<br># HiSax supp=
orted cards<br>#<br>CONFIG_HISAX_16_3=3Dy<br>CONFIG_HISAX_TELESPCI=3Dy<br>C=
ONFIG_HISAX_S0BOX=3Dy<br>CONFIG_HISAX_FRITZPCI=3Dy<br>CONFIG_HISAX_AVM_A1_P=
CMCIA=3Dy<br>
CONFIG_HISAX_ELSA=3Dy<br>CONFIG_HISAX_DIEHLDIVA=3Dy<br>CONFIG_HISAX_SEDLBAU=
ER=3Dy<br>CONFIG_HISAX_NETJET=3Dy<br>CONFIG_HISAX_NETJET_U=3Dy<br>CONFIG_HI=
SAX_NICCY=3Dy<br>CONFIG_HISAX_BKM_A4T=3Dy<br>CONFIG_HISAX_SCT_QUADRO=3Dy<br=
>CONFIG_HISAX_GAZEL=3Dy<br>
CONFIG_HISAX_HFC_PCI=3Dy<br>CONFIG_HISAX_W6692=3Dy<br>CONFIG_HISAX_HFC_SX=
=3Dy<br>CONFIG_HISAX_ENTERNOW_PCI=3Dy<br># CONFIG_HISAX_DEBUG is not set<br=
><br>#<br># HiSax PCMCIA card service modules<br>#<br>CONFIG_HISAX_SEDLBAUE=
R_CS=3Dm<br>
CONFIG_HISAX_ELSA_CS=3Dm<br>CONFIG_HISAX_AVM_A1_CS=3Dm<br>CONFIG_HISAX_TELE=
S_CS=3Dm<br><br>#<br># HiSax sub driver modules<br>#<br>CONFIG_HISAX_ST5481=
=3Dm<br># CONFIG_HISAX_HFCUSB is not set<br>CONFIG_HISAX_HFC4S8S=3Dm<br>CON=
FIG_HISAX_FRITZ_PCIPNP=3Dm<br>
<br>#<br># Active cards<br>#<br>CONFIG_ISDN_CAPI=3Dm<br>CONFIG_ISDN_DRV_AVM=
B1_VERBOSE_REASON=3Dy<br># CONFIG_CAPI_TRACE is not set<br>CONFIG_ISDN_CAPI=
_MIDDLEWARE=3Dy<br>CONFIG_ISDN_CAPI_CAPI20=3Dm<br>CONFIG_ISDN_CAPI_CAPIFS_B=
OOL=3Dy<br>
CONFIG_ISDN_CAPI_CAPIFS=3Dm<br>CONFIG_ISDN_CAPI_CAPIDRV=3Dm<br><br>#<br># C=
API hardware drivers<br>#<br>CONFIG_CAPI_AVM=3Dy<br>CONFIG_ISDN_DRV_AVMB1_B=
1PCI=3Dm<br>CONFIG_ISDN_DRV_AVMB1_B1PCIV4=3Dy<br>CONFIG_ISDN_DRV_AVMB1_B1PC=
MCIA=3Dm<br>
CONFIG_ISDN_DRV_AVMB1_AVM_CS=3Dm<br>CONFIG_ISDN_DRV_AVMB1_T1PCI=3Dm<br>CONF=
IG_ISDN_DRV_AVMB1_C4=3Dm<br>CONFIG_CAPI_EICON=3Dy<br>CONFIG_ISDN_DIVAS=3Dm<=
br>CONFIG_ISDN_DIVAS_BRIPCI=3Dy<br>CONFIG_ISDN_DIVAS_PRIPCI=3Dy<br>CONFIG_I=
SDN_DIVAS_DIVACAPI=3Dm<br>
CONFIG_ISDN_DIVAS_USERIDI=3Dm<br>CONFIG_ISDN_DIVAS_MAINT=3Dm<br>CONFIG_ISDN=
_DRV_GIGASET=3Dm<br># CONFIG_GIGASET_CAPI is not set<br>CONFIG_GIGASET_I4L=
=3Dy<br># CONFIG_GIGASET_DUMMYLL is not set<br>CONFIG_GIGASET_BASE=3Dm<br>C=
ONFIG_GIGASET_M105=3Dm<br>
CONFIG_GIGASET_M101=3Dm<br># CONFIG_GIGASET_DEBUG is not set<br>CONFIG_HYSD=
N=3Dm<br>CONFIG_HYSDN_CAPI=3Dy<br>CONFIG_MISDN=3Dm<br>CONFIG_MISDN_DSP=3Dm<=
br>CONFIG_MISDN_L1OIP=3Dm<br><br>#<br># mISDN hardware drivers<br>#<br>CONF=
IG_MISDN_HFCPCI=3Dm<br>
CONFIG_MISDN_HFCMULTI=3Dm<br>CONFIG_MISDN_HFCUSB=3Dm<br># CONFIG_MISDN_AVMF=
RITZ is not set<br># CONFIG_MISDN_SPEEDFAX is not set<br># CONFIG_MISDN_INF=
INEON is not set<br># CONFIG_MISDN_W6692 is not set<br># CONFIG_MISDN_NETJE=
T is not set<br>
CONFIG_ISDN_HDLC=3Dm<br># CONFIG_PHONE is not set<br><br>#<br># Input devic=
e support<br>#<br>CONFIG_INPUT=3Dy<br>CONFIG_INPUT_FF_MEMLESS=3Dy<br>CONFIG=
_INPUT_POLLDEV=3Dm<br>CONFIG_INPUT_SPARSEKMAP=3Dm<br><br>#<br># Userland in=
terfaces<br>
#<br>CONFIG_INPUT_MOUSEDEV=3Dy<br># CONFIG_INPUT_MOUSEDEV_PSAUX is not set<=
br>CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024<br>CONFIG_INPUT_MOUSEDEV_SCREEN_Y=
=3D768<br>CONFIG_INPUT_JOYDEV=3Dm<br>CONFIG_INPUT_EVDEV=3Dy<br># CONFIG_INP=
UT_EVBUG is not set<br>
<br>#<br># Input Device Drivers<br>#<br>CONFIG_INPUT_KEYBOARD=3Dy<br># CONF=
IG_KEYBOARD_ADP5588 is not set<br>CONFIG_KEYBOARD_ATKBD=3Dy<br># CONFIG_QT2=
160 is not set<br># CONFIG_KEYBOARD_LKKBD is not set<br># CONFIG_KEYBOARD_L=
M8323 is not set<br>
# CONFIG_KEYBOARD_MAX7359 is not set<br># CONFIG_KEYBOARD_NEWTON is not set=
<br># CONFIG_KEYBOARD_OPENCORES is not set<br># CONFIG_KEYBOARD_STOWAWAY is=
 not set<br># CONFIG_KEYBOARD_SUNKBD is not set<br># CONFIG_KEYBOARD_XTKBD =
is not set<br>
CONFIG_INPUT_MOUSE=3Dy<br>CONFIG_MOUSE_PS2=3Dy<br>CONFIG_MOUSE_PS2_ALPS=3Dy=
<br>CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy<br>CONFIG_MOUSE_PS2_SYNAPTICS=3Dy<br>CON=
FIG_MOUSE_PS2_LIFEBOOK=3Dy<br>CONFIG_MOUSE_PS2_TRACKPOINT=3Dy<br>CONFIG_MOU=
SE_PS2_ELANTECH=3Dy<br>
# CONFIG_MOUSE_PS2_SENTELIC is not set<br># CONFIG_MOUSE_PS2_TOUCHKIT is no=
t set<br>CONFIG_MOUSE_SERIAL=3Dm<br>CONFIG_MOUSE_APPLETOUCH=3Dm<br>CONFIG_M=
OUSE_BCM5974=3Dm<br>CONFIG_MOUSE_VSXXXAA=3Dm<br># CONFIG_MOUSE_SYNAPTICS_I2=
C is not set<br>
CONFIG_INPUT_JOYSTICK=3Dy<br>CONFIG_JOYSTICK_ANALOG=3Dm<br>CONFIG_JOYSTICK_=
A3D=3Dm<br>CONFIG_JOYSTICK_ADI=3Dm<br>CONFIG_JOYSTICK_COBRA=3Dm<br>CONFIG_J=
OYSTICK_GF2K=3Dm<br>CONFIG_JOYSTICK_GRIP=3Dm<br>CONFIG_JOYSTICK_GRIP_MP=3Dm=
<br>CONFIG_JOYSTICK_GUILLEMOT=3Dm<br>
CONFIG_JOYSTICK_INTERACT=3Dm<br>CONFIG_JOYSTICK_SIDEWINDER=3Dm<br>CONFIG_JO=
YSTICK_TMDC=3Dm<br>CONFIG_JOYSTICK_IFORCE=3Dm<br>CONFIG_JOYSTICK_IFORCE_USB=
=3Dy<br>CONFIG_JOYSTICK_IFORCE_232=3Dy<br>CONFIG_JOYSTICK_WARRIOR=3Dm<br>CO=
NFIG_JOYSTICK_MAGELLAN=3Dm<br>
CONFIG_JOYSTICK_SPACEORB=3Dm<br>CONFIG_JOYSTICK_SPACEBALL=3Dm<br>CONFIG_JOY=
STICK_STINGER=3Dm<br>CONFIG_JOYSTICK_TWIDJOY=3Dm<br>CONFIG_JOYSTICK_ZHENHUA=
=3Dm<br>CONFIG_JOYSTICK_DB9=3Dm<br>CONFIG_JOYSTICK_GAMECON=3Dm<br>CONFIG_JO=
YSTICK_TURBOGRAFX=3Dm<br>
CONFIG_JOYSTICK_JOYDUMP=3Dm<br>CONFIG_JOYSTICK_XPAD=3Dm<br>CONFIG_JOYSTICK_=
XPAD_FF=3Dy<br>CONFIG_JOYSTICK_XPAD_LEDS=3Dy<br>CONFIG_INPUT_TABLET=3Dy<br>=
CONFIG_TABLET_USB_ACECAD=3Dm<br>CONFIG_TABLET_USB_AIPTEK=3Dm<br>CONFIG_TABL=
ET_USB_GTCO=3Dm<br>
CONFIG_TABLET_USB_KBTAB=3Dm<br>CONFIG_TABLET_USB_WACOM=3Dm<br>CONFIG_INPUT_=
TOUCHSCREEN=3Dy<br># CONFIG_TOUCHSCREEN_AD7879_I2C is not set<br># CONFIG_T=
OUCHSCREEN_AD7879 is not set<br># CONFIG_TOUCHSCREEN_DYNAPRO is not set<br>=
# CONFIG_TOUCHSCREEN_EETI is not set<br>
CONFIG_TOUCHSCREEN_FUJITSU=3Dm<br>CONFIG_TOUCHSCREEN_GUNZE=3Dm<br>CONFIG_TO=
UCHSCREEN_ELO=3Dm<br>CONFIG_TOUCHSCREEN_WACOM_W8001=3Dm<br># CONFIG_TOUCHSC=
REEN_MCS5000 is not set<br>CONFIG_TOUCHSCREEN_MTOUCH=3Dm<br>CONFIG_TOUCHSCR=
EEN_INEXIO=3Dm<br>
CONFIG_TOUCHSCREEN_MK712=3Dm<br>CONFIG_TOUCHSCREEN_PENMOUNT=3Dm<br>CONFIG_T=
OUCHSCREEN_TOUCHRIGHT=3Dm<br>CONFIG_TOUCHSCREEN_TOUCHWIN=3Dm<br># CONFIG_TO=
UCHSCREEN_WM97XX is not set<br>CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dm<br>CONF=
IG_TOUCHSCREEN_USB_EGALAX=3Dy<br>
CONFIG_TOUCHSCREEN_USB_PANJIT=3Dy<br>CONFIG_TOUCHSCREEN_USB_3M=3Dy<br>CONFI=
G_TOUCHSCREEN_USB_ITM=3Dy<br>CONFIG_TOUCHSCREEN_USB_ETURBO=3Dy<br>CONFIG_TO=
UCHSCREEN_USB_GUNZE=3Dy<br>CONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy<br>CONFIG_T=
OUCHSCREEN_USB_IRTOUCH=3Dy<br>
CONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy<br>CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=
=3Dy<br>CONFIG_TOUCHSCREEN_USB_GOTOP=3Dy<br>CONFIG_TOUCHSCREEN_USB_JASTEC=
=3Dy<br>CONFIG_TOUCHSCREEN_USB_E2I=3Dy<br>CONFIG_TOUCHSCREEN_USB_ZYTRONIC=
=3Dy<br>CONFIG_TOUCHSCREEN_USB_ETT_TC5UH=3Dy<br>
CONFIG_TOUCHSCREEN_USB_NEXIO=3Dy<br>CONFIG_TOUCHSCREEN_TOUCHIT213=3Dm<br>CO=
NFIG_TOUCHSCREEN_TSC2007=3Dm<br>CONFIG_INPUT_MISC=3Dy<br>CONFIG_INPUT_PCSPK=
R=3Dm<br>CONFIG_INPUT_APANEL=3Dm<br>CONFIG_INPUT_ATLAS_BTNS=3Dm<br>CONFIG_I=
NPUT_ATI_REMOTE=3Dm<br>
CONFIG_INPUT_ATI_REMOTE2=3Dm<br>CONFIG_INPUT_KEYSPAN_REMOTE=3Dm<br>CONFIG_I=
NPUT_POWERMATE=3Dm<br>CONFIG_INPUT_YEALINK=3Dm<br>CONFIG_INPUT_CM109=3Dm<br=
>CONFIG_INPUT_UINPUT=3Dm<br># CONFIG_INPUT_WINBOND_CIR is not set<br><br>#<=
br># Hardware I/O ports<br>
#<br>CONFIG_SERIO=3Dy<br>CONFIG_SERIO_I8042=3Dy<br>CONFIG_SERIO_SERPORT=3Dy=
<br># CONFIG_SERIO_CT82C710 is not set<br># CONFIG_SERIO_PARKBD is not set<=
br># CONFIG_SERIO_PCIPS2 is not set<br>CONFIG_SERIO_LIBPS2=3Dy<br>CONFIG_SE=
RIO_RAW=3Dm<br>
# CONFIG_SERIO_ALTERA_PS2 is not set<br>CONFIG_GAMEPORT=3Dm<br>CONFIG_GAMEP=
ORT_NS558=3Dm<br>CONFIG_GAMEPORT_L4=3Dm<br>CONFIG_GAMEPORT_EMU10K1=3Dm<br>C=
ONFIG_GAMEPORT_FM801=3Dm<br><br>#<br># Character devices<br>#<br>CONFIG_VT=
=3Dy<br>CONFIG_CONSOLE_TRANSLATIONS=3Dy<br>
CONFIG_VT_CONSOLE=3Dy<br>CONFIG_HW_CONSOLE=3Dy<br>CONFIG_VT_HW_CONSOLE_BIND=
ING=3Dy<br># CONFIG_DEVKMEM is not set<br>CONFIG_SERIAL_NONSTANDARD=3Dy<br>=
# CONFIG_COMPUTONE is not set<br>CONFIG_ROCKETPORT=3Dm<br>CONFIG_CYCLADES=
=3Dm<br># CONFIG_CYZ_INTR is not set<br>
# CONFIG_DIGIEPCA is not set<br># CONFIG_MOXA_INTELLIO is not set<br># CONF=
IG_MOXA_SMARTIO is not set<br># CONFIG_ISI is not set<br>CONFIG_SYNCLINK=3D=
m<br>CONFIG_SYNCLINKMP=3Dm<br>CONFIG_SYNCLINK_GT=3Dm<br>CONFIG_N_HDLC=3Dm<b=
r># CONFIG_RISCOM8 is not set<br>
# CONFIG_SPECIALIX is not set<br># CONFIG_STALDRV is not set<br>CONFIG_NOZO=
MI=3Dm<br><br>#<br># Serial drivers<br>#<br>CONFIG_SERIAL_8250=3Dy<br>CONFI=
G_SERIAL_8250_CONSOLE=3Dy<br>CONFIG_FIX_EARLYCON_MEM=3Dy<br>CONFIG_SERIAL_8=
250_PCI=3Dy<br>
CONFIG_SERIAL_8250_PNP=3Dy<br>CONFIG_SERIAL_8250_CS=3Dm<br>CONFIG_SERIAL_82=
50_NR_UARTS=3D32<br>CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4<br>CONFIG_SERIAL_8=
250_EXTENDED=3Dy<br>CONFIG_SERIAL_8250_MANY_PORTS=3Dy<br>CONFIG_SERIAL_8250=
_SHARE_IRQ=3Dy<br>
CONFIG_SERIAL_8250_DETECT_IRQ=3Dy<br>CONFIG_SERIAL_8250_RSA=3Dy<br><br>#<br=
># Non-8250 serial port support<br>#<br>CONFIG_SERIAL_CORE=3Dy<br>CONFIG_SE=
RIAL_CORE_CONSOLE=3Dy<br>CONFIG_CONSOLE_POLL=3Dy<br>CONFIG_SERIAL_JSM=3Dm<b=
r># CONFIG_SERIAL_TIMBERDALE is not set<br>
CONFIG_UNIX98_PTYS=3Dy<br>CONFIG_DEVPTS_MULTIPLE_INSTANCES=3Dy<br># CONFIG_=
LEGACY_PTYS is not set<br>CONFIG_PRINTER=3Dm<br>CONFIG_LP_CONSOLE=3Dy<br>CO=
NFIG_PPDEV=3Dm<br>CONFIG_IPMI_HANDLER=3Dm<br># CONFIG_IPMI_PANIC_EVENT is n=
ot set<br>
CONFIG_IPMI_DEVICE_INTERFACE=3Dm<br>CONFIG_IPMI_SI=3Dm<br>CONFIG_IPMI_WATCH=
DOG=3Dm<br>CONFIG_IPMI_POWEROFF=3Dm<br>CONFIG_HW_RANDOM=3Dy<br># CONFIG_HW_=
RANDOM_TIMERIOMEM is not set<br>CONFIG_HW_RANDOM_INTEL=3Dm<br>CONFIG_HW_RAN=
DOM_AMD=3Dm<br>
CONFIG_HW_RANDOM_VIA=3Dy<br>CONFIG_NVRAM=3Dy<br>CONFIG_R3964=3Dm<br># CONFI=
G_APPLICOM is not set<br><br>#<br># PCMCIA character devices<br>#<br># CONF=
IG_SYNCLINK_CS is not set<br>CONFIG_CARDMAN_4000=3Dm<br>CONFIG_CARDMAN_4040=
=3Dm<br>
CONFIG_IPWIRELESS=3Dm<br>CONFIG_MWAVE=3Dm<br># CONFIG_PC8736x_GPIO is not s=
et<br>CONFIG_RAW_DRIVER=3Dy<br>CONFIG_MAX_RAW_DEVS=3D8192<br>CONFIG_HPET=3D=
y<br># CONFIG_HPET_MMAP is not set<br>CONFIG_HANGCHECK_TIMER=3Dm<br>CONFIG_=
TCG_TPM=3Dm<br>
CONFIG_TCG_TIS=3Dm<br>CONFIG_TCG_NSC=3Dm<br>CONFIG_TCG_ATMEL=3Dm<br>CONFIG_=
TCG_INFINEON=3Dm<br>CONFIG_TELCLOCK=3Dm<br>CONFIG_DEVPORT=3Dy<br>CONFIG_I2C=
=3Dm<br>CONFIG_I2C_BOARDINFO=3Dy<br># CONFIG_I2C_COMPAT is not set<br># CON=
FIG_I2C_CHARDEV is not set<br>
# CONFIG_I2C_HELPER_AUTO is not set<br>CONFIG_I2C_SMBUS=3Dm<br><br>#<br># I=
2C Algorithms<br>#<br>CONFIG_I2C_ALGOBIT=3Dm<br># CONFIG_I2C_ALGOPCF is not=
 set<br>CONFIG_I2C_ALGOPCA=3Dm<br><br>#<br># I2C Hardware Bus support<br>#<=
br>
<br>#<br># PC SMBus host controller drivers<br>#<br># CONFIG_I2C_ALI1535 is=
 not set<br># CONFIG_I2C_ALI1563 is not set<br># CONFIG_I2C_ALI15X3 is not =
set<br>CONFIG_I2C_AMD756=3Dm<br>CONFIG_I2C_AMD756_S4882=3Dm<br>CONFIG_I2C_A=
MD8111=3Dm<br>
CONFIG_I2C_I801=3Dm<br>CONFIG_I2C_ISCH=3Dm<br>CONFIG_I2C_PIIX4=3Dm<br>CONFI=
G_I2C_NFORCE2=3Dm<br>CONFIG_I2C_NFORCE2_S4985=3Dm<br># CONFIG_I2C_SIS5595 i=
s not set<br># CONFIG_I2C_SIS630 is not set<br>CONFIG_I2C_SIS96X=3Dm<br>CON=
FIG_I2C_VIA=3Dm<br>
CONFIG_I2C_VIAPRO=3Dm<br><br>#<br># ACPI drivers<br>#<br># CONFIG_I2C_SCMI =
is not set<br><br>#<br># I2C system bus drivers (mostly embedded / system-o=
n-chip)<br>#<br># CONFIG_I2C_OCORES is not set<br>CONFIG_I2C_SIMTEC=3Dm<br>
# CONFIG_I2C_XILINX is not set<br><br>#<br># External I2C/SMBus adapter dri=
vers<br>#<br>CONFIG_I2C_PARPORT=3Dm<br>CONFIG_I2C_PARPORT_LIGHT=3Dm<br># CO=
NFIG_I2C_TAOS_EVM is not set<br>CONFIG_I2C_TINY_USB=3Dm<br><br>#<br># Other=
 I2C/SMBus bus drivers<br>
#<br>CONFIG_I2C_PCA_PLATFORM=3Dm<br>CONFIG_I2C_STUB=3Dm<br># CONFIG_I2C_DEB=
UG_CORE is not set<br># CONFIG_I2C_DEBUG_ALGO is not set<br># CONFIG_I2C_DE=
BUG_BUS is not set<br># CONFIG_SPI is not set<br><br>#<br># PPS support<br>
#<br># CONFIG_PPS is not set<br>CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy<br># =
CONFIG_GPIOLIB is not set<br>CONFIG_W1=3Dm<br>CONFIG_W1_CON=3Dy<br><br>#<br=
># 1-wire Bus Masters<br>#<br># CONFIG_W1_MASTER_MATROX is not set<br>CONFI=
G_W1_MASTER_DS2490=3Dm<br>
CONFIG_W1_MASTER_DS2482=3Dm<br><br>#<br># 1-wire Slaves<br>#<br>CONFIG_W1_S=
LAVE_THERM=3Dm<br>CONFIG_W1_SLAVE_SMEM=3Dm<br>CONFIG_W1_SLAVE_DS2431=3Dm<br=
>CONFIG_W1_SLAVE_DS2433=3Dm<br>CONFIG_W1_SLAVE_DS2433_CRC=3Dy<br>CONFIG_W1_=
SLAVE_DS2760=3Dm<br>
CONFIG_W1_SLAVE_BQ27000=3Dm<br>CONFIG_POWER_SUPPLY=3Dy<br># CONFIG_POWER_SU=
PPLY_DEBUG is not set<br># CONFIG_PDA_POWER is not set<br># CONFIG_BATTERY_=
DS2760 is not set<br># CONFIG_BATTERY_DS2782 is not set<br>CONFIG_BATTERY_B=
Q27x00=3Dm<br>
# CONFIG_BATTERY_MAX17040 is not set<br>CONFIG_HWMON=3Dm<br>CONFIG_HWMON_VI=
D=3Dm<br># CONFIG_HWMON_DEBUG_CHIP is not set<br><br>#<br># Native drivers<=
br>#<br>CONFIG_SENSORS_ABITUGURU=3Dm<br>CONFIG_SENSORS_ABITUGURU3=3Dm<br>CO=
NFIG_SENSORS_AD7414=3Dm<br>
CONFIG_SENSORS_AD7418=3Dm<br>CONFIG_SENSORS_ADM1021=3Dm<br>CONFIG_SENSORS_A=
DM1025=3Dm<br>CONFIG_SENSORS_ADM1026=3Dm<br>CONFIG_SENSORS_ADM1029=3Dm<br>C=
ONFIG_SENSORS_ADM1031=3Dm<br>CONFIG_SENSORS_ADM9240=3Dm<br># CONFIG_SENSORS=
_ADT7411 is not set<br>
CONFIG_SENSORS_ADT7462=3Dm<br>CONFIG_SENSORS_ADT7470=3Dm<br>CONFIG_SENSORS_=
ADT7475=3Dm<br># CONFIG_SENSORS_ASC7621 is not set<br>CONFIG_SENSORS_K8TEMP=
=3Dm<br># CONFIG_SENSORS_K10TEMP is not set<br>CONFIG_SENSORS_ASB100=3Dm<br=
>CONFIG_SENSORS_ATXP1=3Dm<br>
CONFIG_SENSORS_DS1621=3Dm<br>CONFIG_SENSORS_I5K_AMB=3Dm<br>CONFIG_SENSORS_F=
71805F=3Dm<br>CONFIG_SENSORS_F71882FG=3Dm<br>CONFIG_SENSORS_F75375S=3Dm<br>=
CONFIG_SENSORS_FSCHMD=3Dm<br># CONFIG_SENSORS_G760A is not set<br>CONFIG_SE=
NSORS_GL518SM=3Dm<br>
CONFIG_SENSORS_GL520SM=3Dm<br>CONFIG_SENSORS_CORETEMP=3Dm<br>CONFIG_SENSORS=
_IBMAEM=3Dm<br>CONFIG_SENSORS_IBMPEX=3Dm<br>CONFIG_SENSORS_IT87=3Dm<br>CONF=
IG_SENSORS_LM63=3Dm<br># CONFIG_SENSORS_LM73 is not set<br>CONFIG_SENSORS_L=
M75=3Dm<br>
CONFIG_SENSORS_LM77=3Dm<br>CONFIG_SENSORS_LM78=3Dm<br>CONFIG_SENSORS_LM80=
=3Dm<br>CONFIG_SENSORS_LM83=3Dm<br>CONFIG_SENSORS_LM85=3Dm<br>CONFIG_SENSOR=
S_LM87=3Dm<br>CONFIG_SENSORS_LM90=3Dm<br>CONFIG_SENSORS_LM92=3Dm<br>CONFIG_=
SENSORS_LM93=3Dm<br>
# CONFIG_SENSORS_LTC4215 is not set<br>CONFIG_SENSORS_LTC4245=3Dm<br># CONF=
IG_SENSORS_LM95241 is not set<br>CONFIG_SENSORS_MAX1619=3Dm<br>CONFIG_SENSO=
RS_MAX6650=3Dm<br>CONFIG_SENSORS_PC87360=3Dm<br>CONFIG_SENSORS_PC87427=3Dm<=
br>CONFIG_SENSORS_PCF8591=3Dm<br>
CONFIG_SENSORS_SIS5595=3Dm&lt;</blockquote></div></div></div>...<br><br>[=
=D3=CA=BC=FE=B2=BF=B7=D6=D2=FE=B2=D8]&nbsp;&nbsp;</blockquote></div><br><br=
 clear=3D"all"><br>-- <br>Best wishes<br>(CN:=BB=C6=D0=F1,Huang xu)--------=
(EN:alamo)<br>@Class Three Major in Embeded System@domain.hid USTC,<br>
166, Ren-ai Road, Suzhou, Jiangsu, P.R. China<br>215123<br>MAIL:lovealamo (=
AT) <a href=3D"http://gmail.com">gmail.com</a><br>TEL:18915412309<br>

--20cf305b0e027f32dc049ee81177--

