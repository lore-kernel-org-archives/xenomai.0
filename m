Message-ID: <40C42A0D.5070501@domain.hid>
Date: Mon, 07 Jun 2004 10:40:45 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: Patch/Code maintanance
References: <20040604155437.6D41AC109F@atlas.denx.de>
In-Reply-To: <20040604155437.6D41AC109F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
To: Wolfgang Denk <wd@domain.hid>
Cc: rpm@xenomai.org, adeos-main <adeos-main@gna.org>

On 06/04/2004 05:54 PM Wolfgang Denk wrote:
> Hi Wolfgang,
> 
> in message <40C03997.5040805@domain.hid> you wrote:
>> 
>> -	gcc $(CFLAGS) -o $@ -c $<
>> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
> ...
>> -	gcc $(CFLAGS) -o $@ -c $<
>> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
> ...
>> -	gcc $(CFLAGS) -o $@ -c $<
>> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
> ...
>> -	gcc $(CFLAGS) -o $@ -c $<
>> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
> 
> Why don't you simply define
> 
> 	CC = $(CROSS_COMPILE)gcc
> 
> _once_ at the beginning of the Makefile, and  then  use  $(CC)  only?
> This is IMHO much easier to maintain.

Of course. Thanks for the hint.

Wolfgang.

