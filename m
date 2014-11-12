Date: Wed, 12 Nov 2014 16:13:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112151305.GW17476@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C676CD2D@SINTEFEXMBX05.sintef.no>
 <20141111140230.GA17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676CE2D@SINTEFEXMBX05.sintef.no>
 <314E5ECDAA86314791309FA670550F89C676E884@SINTEFEXMBX05.sintef.no>
 <20141112134531.GP17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676EB35@SINTEFEXMBX05.sintef.no>
 <20141112145117.GV17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676EBE1@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676EBE1@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] xeno_16550A driver install problems.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Wed, Nov 12, 2014 at 02:52:54PM +0000, Terje Frøysa wrote:
> Ok Gilles,
> 
> Thanks!
> 
> Terje

Please try the (completely untested, not even compiled) following
patch. It should add two parameter to the xeno_16650 module,
allowing to change the register shift and register width. For
omap-serial, you want regshift=2 and regwidth=2

diff --git a/ksrc/drivers/serial/16550A_io.h b/ksrc/drivers/serial/16550A_io.h
index 92d21a5..bf05498 100644
--- a/ksrc/drivers/serial/16550A_io.h
+++ b/ksrc/drivers/serial/16550A_io.h
@@ -33,6 +33,13 @@ static unsigned long mem[MAX_DEVICES];
 static void *mapped_io[MAX_DEVICES];
 compat_module_param_array(mem, ulong, MAX_DEVICES, 0400);
 MODULE_PARM_DESC(mem, "I/O memory addresses of the serial devices");
+static unsigned regshift = 0;
+module_param(regshift, uint, 0400);
+MODULE_PARM_DESC(regshift, "Register shift to be used");
+static unsigned regwidth = 1;
+module_param(regwidth, uint, 0400);
+MODULE_PARM_DESC(regwidth, "Register width to be used (1, 2 or 4)");
+
 #endif /* CONFIG_XENO_DRIVERS_16550A_MMIO || CONFIG_XENO_DRIVERS_16550A_ANY */
 
 #ifdef CONFIG_XENO_DRIVERS_16550A_PIO
@@ -164,7 +171,19 @@ rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off)
 	case MODE_PIO:
 		return inb(base + off);
 	default: /* MODE_MMIO */
-		return readb((void *)base + off);
+		switch (regwidth) {
+		case 1:
+			readb((void *)base + (off << regshift));
+			break;
+		case 2:
+			readw((void *)base + (off << regshift));
+			break;
+		case 4:
+			readl((void *)base + (off << regshift));
+			break;
+		default:
+			BUG();
+		}
 	}
 }
 
@@ -176,7 +195,19 @@ rt_16550_reg_out(io_mode_t io_mode, unsigned long base, int off, u8 val)
 		outb(val, base + off);
 		break;
 	case MODE_MMIO:
-		writeb(val, (void *)base + off);
+		switch (regwidth) {
+		case 1:
+			writeb(val, (void *)base + (off << regshift));
+			break;
+		case 2:
+			writew(val, (void *)base + (off << regshift));
+			break;
+		case 4:
+			writel(val, (void *)base + (off << regshift));
+			break;
+		default:
+			BUG();
+		}
 		break;
 	}
 }


-- 
					    Gilles.

