Date: Mon, 29 Mar 2010 01:35:56 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100328233556.GC2542@domain.hid>
References: <4BACBFDC.4080909@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BACBFDC.4080909@domain.hid>
Subject: Re: [Xenomai-core] Bug in a4l_get_chan
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

Daniele Nicolodi wrote:
> Hello Alexis,
> 
> I found that a4l_get_chan() in buffer.c does not work for subdevices
> that use a global channels description struct (mode =
> A4L_CHAN_GLOBAL_CHANDESC in the a4l_chdesc_t structure).
> 
> The problem is that a4l_get_chan() iterates (twice) on the chan_desc
> array looking for channel descriptions at indexes higher than 0, also in
> the case where those are not populated because the subdevice uses a
> single channel description structure for all channels.
> 
> This bug is quite bas, as it triggers a kernel oops for a integer
> division by zero when an a4l_cmd_t command is issued with a channels
> description array that does not have the channel id 0 as first acquired
> channel. You can easily reproduce the bug using the ni_pcimio driver,
> using cmd_read with the parameter -c 1.
> 
> I'm looking into providing a patch, but I have some difficulties in
> understanding the rational of this part of analogy code...

I have some troubles with my dev environment (and I am in a hurry). So
I was not able to test this patch on my NI board. 

However, with your accurate description, I think this patch should
solve the problem:

diff --git a/ksrc/drivers/analogy/buffer.c b/ksrc/drivers/analogy/buffer.c
index bbd79ec..3ec558a 100644
--- a/ksrc/drivers/analogy/buffer.c
+++ b/ksrc/drivers/analogy/buffer.c
@@ -112,7 +112,7 @@ a4l_cmd_t *a4l_get_cmd(a4l_subd_t *subd)
 int a4l_get_chan(a4l_subd_t *subd)
 {
 	a4l_dev_t *dev = subd->dev;
-	int i, tmp_count, tmp_size = 0;	
+	int i, j, tmp_count, tmp_size = 0;	
 	a4l_cmd_t *cmd;
 
 	/* Check that subdevice supports commands */
@@ -132,9 +132,11 @@ int a4l_get_chan(a4l_subd_t *subd)
 	/* We assume channels can have different sizes;
 	   so, we have to compute the global size of the channels
 	   in this command... */
-	for (i = 0; i < cmd->nb_chan; i++)
-		tmp_size += dev->transfer.subds[subd->idx]->chan_desc->
-			chans[CR_CHAN(cmd->chan_descs[i])].nb_bits;
+	for (i = 0; i < cmd->nb_chan; i++) {
+		j = (subd->chan_desc->mode != A4L_CHAN_GLOBAL_CHANDESC) ? 
+			CR_CHAN(cmd->chan_descs[i]) : 0;
+		tmp_size += subd->chan_desc->chans[j].nb_bits;
+	}
 
 	/* Translation bits -> bytes */
 	tmp_size /= 8;
@@ -146,9 +148,11 @@ int a4l_get_chan(a4l_subd_t *subd)
 
 	/* ...and find the channel the last munged sample 
 	   was related with */
-	for (i = 0; tmp_count > 0 && i < cmd->nb_chan; i++)
-		tmp_count -= dev->transfer.subds[subd->idx]->chan_desc->
-			chans[CR_CHAN(cmd->chan_descs[i])].nb_bits;
+	for (i = 0; tmp_count > 0 && i < cmd->nb_chan; i++) {
+		j = (subd->chan_desc->mode != A4L_CHAN_GLOBAL_CHANDESC) ? 
+			CR_CHAN(cmd->chan_descs[i]) : 0;
+		tmp_count -= subd->chan_desc->chans[j].nb_bits;
+	}
 
 	if (tmp_count == 0)
 		return i;

Concerning, the rationale of the this code, I understand what you
mean. Firstly, the function is badly named, it is quite hard to find
out its role. Secondly, the case I try to manage is intricate (but
real). 

I will try to explain it tomorrow (with a proposal of a little patch to
set a better name for this function).


> 
> Cheers,
> -- 
> Daniele
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Alexis.

