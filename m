Message-ID: <b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>
Date: Thu, 21 Jun 2007 10:03:49 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <4679A302.2060403@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46782305.4080501@domain.hid>
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>
	<4679A302.2060403@domain.hid>
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On 20/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> [ ... ]
> > xnintr_attach/detach()).. your approach does increase a worst case
> > length of the lock(&intrlock) --> unlock(&intrlock) section... but
> > that's unlikely to be critical.
> >
> > I think, the patch I sent before addresses a reported earlier case
> > with xnintr_edge_shirq_handler().. but your approach does make code
> > shorter (and likely simpler), right? I don't see any problems it would
> > possibly cause (maybe I'm missing smth yet :)
>
> I must confess I didn't get your idea immediately. Later on (cough,
> after hacking my own patch, cough) I had a closer look, and it first
> appeared fairly nice, despite the additional "ifs". But then I realised
> that "end == old_end" may produce false positives in case we have
> several times the same (and only the same) IRQ in a row.
> So, I'm afraid
> we have to live with only one candidate. :->

It's not clear, can you elaborate your (non-working) scenario in more
details? :-)

Note: I sent the second patch with the following correction :

...
                } else if (code == XN_ISR_NONE && end == NULL) {
                        end = intr;
+                        old_end = NULL;
                }
...

I don't see why this idea can't work (even if I made yet another error).
Under some circumstances the following code will be triggered to end a
loop even when 'end' is still valid

                        if (end && old_end == end)
                                intr = NULL;

_but_ it'd be exactly a case when "intr == end" and hence, the loop
would be finished anyway by the "while (intr && intr != end)"
condition.. So sometimes it acts as yet _another_ check to exit the
loop, IOW "while (intr && intr != end)" may be converted to just
"while (intr)".


>
> Jan
>

-- 
Best regards,
Dmitry Adamushko

