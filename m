Message-ID: <4AE96DD3.2020608@domain.hid>
Date: Thu, 29 Oct 2009 11:26:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AE96CBF.3030401@domain.hid>
In-Reply-To: <4AE96CBF.3030401@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] Broken .so generation since dbbd33f50d
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Philippe,
> 
> your commit dbbd33f50d (nios2: introduce architecture support) broke any
> .so generation, at least for x86. Not sure why, but it is related to
> moving AC_PROG_LIBTOOL around in configure.in. You had to push it after
> nios2's AC_DISABLE_SHARED, right?
> 

diff --git a/configure.in b/configure.in
index 71bad26..5e88d57 100644
--- a/configure.in
+++ b/configure.in
@@ -66,6 +66,8 @@ else
   build_for=$host_alias
 fi
 
+AC_ENABLE_SHARED
+
 use__thread=yes
 case "$build_for" in
  i*86*-*)


solves it. I just need to find out if AC_DISABLE_SHARED after enable is
allowed (for the nios2 case).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

