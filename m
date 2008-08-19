Message-ID: <48AA8D27.8020103@domain.hid>
Date: Tue, 19 Aug 2008 11:06:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001b01c8f600$0c5a5a60$09201fac@domain.hid>	<4896B492.4000404@domain.hid>	<005b01c8f615$db466930$09201fac@domain.hid>	<4896D6CC.1040103@domain.hid>	<4896D85D.2010004@domain.hid>
	<48A2BD34.2020601@domain.hid>	<48A2DC45.9040900@domain.hid>
	<48A9C977.9040106@domain.hid> <48AA8BCD.6050508@domain.hid>
In-Reply-To: <48AA8BCD.6050508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] rework xnintr_query
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Philippe Gerum wrote:
>> -	head = snprintf(name, XNOBJECT_NAME_LEN, "IRQ%d: ", irq);
>> -	name += head;
>> -	strncpy(name, intr->name, XNOBJECT_NAME_LEN-head);
>> +	head = snprintf(name_buf, XNOBJECT_NAME_LEN, "IRQ%d: ", irq);
>> +	strncpy(name_buf + head, intr->name, XNOBJECT_NAME_LEN-head);
> 
> -	strncpy(name_buf + head, intr->name, XNOBJECT_NAME_LEN-head);
> +	strncpy(name_buf + head, intr->name, XNOBJECT_NAME_LEN-1-head);
> +	name_buf[XNOBJECT_NAME_LEN-1] = '\0';
> 
> Object names should always be null-terminated.

Yes, and what is the point of not doing everything with only one
snprintf ? strncpy uselessly burns CPU cycles by filling the destination
buffers with zeros if source is smaller than destination.

-- 
                                                 Gilles.

