From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
Date: Wed, 6 Dec 2006 17:05:54 +0100
References: <E1GrHXk-00023w-Oq@domain.hid>
	<E1Grrzu-0008JP-G8@domain.hid> <45769862.1060208@domain.hid>
In-Reply-To: <45769862.1060208@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ipudF+djPOga5+A"
Message-Id: <E1GrzHI-0003oE-S6@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, adeos-main@gna.org

--Boundary-00=_ipudF+djPOga5+A
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jan Kiszka wrote:
> Then would you mind moving the trace enabling point as I said and post a
> patch?

See attachment.

> And if you have any idea for a characteristic CONFIG-switch that 
> should lower the default TRACE_SHIFT (CONFIG_EMBEDDED? Or per arch?),
> you are welcome as well. TIA.

Why not lower the default value globally to 13?

--
Sebastian

--Boundary-00=_ipudF+djPOga5+A
Content-Type: text/x-diff; charset="iso-8859-15";
	name="ipipe_tracer_postpone_enable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ipipe_tracer_postpone_enable.patch"

--- ipipe/v2.6/common/kernel/ipipe/tracer.c	2006-10-12 20:08:50.000000000 +0200
+++ ipipe.work/v2.6/common/kernel/ipipe/tracer.c	2006-12-06 16:53:23.000000000 +0100
@@ -100,12 +100,10 @@ enum ipipe_trace_type
 
 
 #ifdef CONFIG_IPIPE_TRACE_VMALLOC
-#define IPIPE_DEFAULT_TRACE_STATE   0
 
 static struct ipipe_trace_path *trace_paths[NR_CPUS];
 
 #else /* !CONFIG_IPIPE_TRACE_VMALLOC */
-#define IPIPE_DEFAULT_TRACE_STATE   CONFIG_IPIPE_TRACE_ENABLE_VALUE
 
 static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS] =
 	{ [0 ... NR_CPUS-1] =
@@ -115,7 +113,7 @@ static struct ipipe_trace_path trace_pat
 	};
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
 
-int ipipe_trace_enable = IPIPE_DEFAULT_TRACE_STATE;
+int ipipe_trace_enable = 0;
 
 static int active_path[NR_CPUS] =
 	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_ACTIVE };
@@ -1217,8 +1215,8 @@ void __init __ipipe_init_tracer(void)
 			trace_paths[cpu][path].end   = -1;
 		}
 	}
-	ipipe_trace_enable = CONFIG_IPIPE_TRACE_ENABLE_VALUE;
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
+	ipipe_trace_enable = CONFIG_IPIPE_TRACE_ENABLE_VALUE;
 
 	trace_dir = create_proc_entry("trace", S_IFDIR, ipipe_proc_root);
 

--Boundary-00=_ipudF+djPOga5+A--

