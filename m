Message-ID: <b647ffbd0701100635k3fbec704r28fd6ec3f8439e2e@domain.hid>
Date: Wed, 10 Jan 2007 15:35:19 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name
	leads
In-Reply-To: <27256731.1168438778663.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>
	<45A4DDA8.6090800@domain.hid>
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
	<45A4F18A.4040209@domain.hid>
	<27256731.1168438778663.JavaMail.ngmail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On 10/01/07, M. Koehrer <mathias_koehrer@domain.hid> wrote:
> Hi,
>
> one more comment on this issue:
> Regarding to the API documentation it is not required to use a static allocated
> string for the name parameter
> (API docu: "When non-NULL and non-empty, this string is copied to a safe place into the descriptor").
>
> However, when I use a name variable that is created on the stack (using sprintf), I see
> that the /proc/xenomai/registry/native/interrupts/xxx  name is fine, however the name in
> /proc/xenomai/irq is not valid.
> I.e. I have to use a static name variable to pass to rt_inter_create() as the name pointer
> seems to be used without a copy action in /proc/xenomai/irq.

You didn't apply the patches I sent, did you?

The second patch (intr_swap.patch) should address this issue.


-- 
Best regards,
Dmitry Adamushko

