Message-ID: <5136FC1E.6060608@xenomai.org>
Date: Wed, 06 Mar 2013 09:19:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>	<5130B39C.70300@hilscher.com>
	<513465CF.4030807@hilscher.com>	<51350D5B.6060309@xenomai.org>
	<5135CCDE.5090401@hilscher.com>	<5135D667.8060309@siemens.com>
	<51361281.20307@hilscher.com> <51364A61.3090002@xenomai.org>
	<5136F9E9.9030604@hilscher.com>
In-Reply-To: <5136F9E9.9030604@hilscher.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerome Poncin <JPoncin@hilscher.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/06/2013 09:10 AM, Jerome Poncin wrote:

> 
> Hello Gilles,
> 
> I don't understand, because I think I did a maximum of modifications

> that you said me...

Not really, both Jan and I gave you (different) reasons why this is wrong:

+static ssize_t cifx_pci_write(struct rtdm_dev_context *context,
+			      rtdm_user_info_t *user_info, const void *buf,
+			      size_t nbyte)
+{
+	struct io_map_mem map_mem;
+	int ret;
+
+	if (nbyte > sizeof(struct io_map_mem))
+		return 0;
+
+	if (nbyte == sizeof(struct io_map_mem)) {
+		/* Copy data information for Kernel */
+		if (rtdm_safe_copy_from_user(user_info, &map_mem, buf, nbyte)) {
+			nbyte = 0;
+		} else {
+			if (*map_mem.virt_addr == NULL) {
+				/* Map physical on virtual memory */
+				ret = rtdm_iomap_to_user(user_info,
+							 (phys_addr_t) map_mem.
+							 phys_addr,
+							 (size_t) map_mem.
+							 length,
+							 (PROT_READ |
+							  PROT_WRITE),
+							 map_mem.virt_addr,
+							 NULL, NULL);
+
+				if (ret != 0)
+					nbyte = 0;
+			} else {
+				/* Unap virtual memory */
+				ret = rtdm_munmap(user_info, *map_mem.virt_addr,
+						  (size_t) map_mem.length);
+
+				if (ret != 0)
+					nbyte = 0;
+			}
+		}
+	} else {
+		/* Error nothing to do */
+		nbyte = 0;
+	}
+
+	return nbyte;
+}

Yet you kept this in the "final" patch.


> 
> I'm agree to test the code if you fixed the code, no problem. Perhaps I
> don't understand what you really want.
> 
> For modification in 80 line, how to change this ? :
> 
> struct pxa_dev_info *pxa_info =
>         (struct pxa_dev_info *)((struct io_info *)info->device_data)->priv;
>     uint32_t __iomem *plx_timing;
> 
> I can't do a function...


Well, first of all you should not use "pxa" as a suffix, as you may know,
there are processors named "pxa", so, this may conflict. Some name related 
to the board would be better, such as "cifx".

Second, there are usually acesssors to things like "device_data" and "priv"
members. 

Thirdly, in C, you do not need an explicit cast when casting from void *, 
to any pointer type, this is what makes using malloc convenient for instance.
So, what you should really do is:

struct io_info *io_info = the_device_data_accessor(info);
struct cifx_dev_info *dev_info = the_priv_accessor(io_info);

-- 
                                                                Gilles.

