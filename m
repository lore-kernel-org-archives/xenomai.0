Subject: Re: [Adeos-main] Re: Patch/Code maintanance 
From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Fri, 04 Jun 2004 10:57:59 +0200."
             <40C03997.5040805@domain.hid> 
Date: Fri, 04 Jun 2004 17:54:32 +0200
Message-Id: <20040604155437.6D41AC109F@atlas.denx.de>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>
Cc: rpm@xenomai.org, adeos-main <adeos-main@gna.org>

Hi Wolfgang,

in message <40C03997.5040805@domain.hid> you wrote:
> 
> -	gcc $(CFLAGS) -o $@ -c $<
> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
...
> -	gcc $(CFLAGS) -o $@ -c $<
> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
...
> -	gcc $(CFLAGS) -o $@ -c $<
> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
...
> -	gcc $(CFLAGS) -o $@ -c $<
> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<

Why don't you simply define

	CC = $(CROSS_COMPILE)gcc

_once_ at the beginning of the Makefile, and  then  use  $(CC)  only?
This is IMHO much easier to maintain.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@domain.hid
If you can't beat it or corrupt it, you pretend it was your  idea  in
the first place.                 - Terry Pratchett, _Guards! Guards!_

