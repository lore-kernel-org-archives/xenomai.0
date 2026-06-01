Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCC38BF89
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302551; cv=none; b=ZvGGDipHA5E4clsXwdFDXY462crKyFEGJ7hwCdhSDgJrFcjL+MJcN9o1omrIfu4SiymL2XgfpYIDEJk8SLhbUZOSqIiAZBkq/geWK5FcbdBvStMMLbP1Y0az8QxfjJZ2VzPSAmjXQ2TYnqXmt0qQrwrMHLLRjX6FrZjwtknm1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302551; c=relaxed/simple;
	bh=3oukh4tpdXPNgl+6qZYIj2P0Y/zmJpdEe6OmAX1L7Dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FX9w9SYHwP/isC/Tt7F26hDQBwEt99+Fhd8F48uTQAKjFSYgk2lF+dTCneUwIfflRsFDWtN8zQg5+PrMQ7H18clR+s05kjART56LNbTipZ7mlrDG9S3vWCu7mB6QWOy97AaUGA00HIv53Fk/Lq3u/56EiaTEgxL6qT48YU95Xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=RofhwA2A; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="RofhwA2A"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 978583EBCF;
	Mon,  1 Jun 2026 08:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780302540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbW2mS98esPMhcYvFxeFDp18+FC7kgaCNR8wzkte8/g=;
	b=RofhwA2AAcRuiIDGuiqRpP6Lxt+42r1X3SKDWZvjLS9DdR9h/ylK6VqQJIGzKt8Ql9O479
	Y8Emc2LFmITd/yfFApfZ++jrC1XX0YFQZa3gYQvApJKO2brmLIDEQEYvS4V7TazvGTzYq4
	z4JAGDyp2Ao9LIS85cchvG+6qJdIyqAdEQ4UAxG3aeq+ZO36NX/WUGW58SZXb+YLixm/Gl
	Jz6KCF052atee8Hg3yipQPLpH0YxLFmJxLDisL+f05BxKEKoP2BJHkFZinAFv+1DWHIUK+
	7bgi7Kk6dQCOptjlV197/fr/dAGWBfQFaTqH+S7Z4sDr77AJ2xDbl/hubJ/W2A==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
In-Reply-To: <20260528194459.6117-2-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Thu, 28 May 2026 21:44:59 +0200")
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
	<20260528194459.6117-2-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 01 Jun 2026 10:29:00 +0200
Message-ID: <87a4te64vn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEr76E7lxt5bsLNkepAsZoH+Bs9SEUYezMIvVXlOb7ThjWlxEPVkHihwfKBINbRe4zVPfvke+XV+iUXMs1qhLcP8brhOwYsFhBlQZpCoK9WPC1VWDeq8XO3OtYuqupbEh90fRipeSXsmewFgt4aol/cIouyroPHdHoJgMHIskZYX9FS0EzIo4LpEmn3PqBs/QkOvXMp2HV4HkRoleEAG7HCYLsOAwZfVSRwvwCTMTXvDAI52KekAhesX+cC6Mm5bWzZgGQZTbYXyjvpGLdh3jECpfg8dDJzViZFGj1CdoQBJgA17KYjAr5DbbHMiFW1Nc3V2r2ucCkEl+ziRz63FMz5s7F7M168T/2zbkasue31VtKpxj7cvw0V4o3Hw38B3H0+CfAvYAVm6dvwreaik5nzsAZqqSwGP49yC3h+XLRF6WRqsbzoNS2AoqPZDotoRm7VgedQqh16Lua1a9tzD/V8v1loQi+da0b8vPNZim55nWVjzzhz5HY87Z+C58BPOulwwaKlV/zLbbmKmnZLfycqcl5/tVSzdD560cVYfgP1lgAKex/RfrXkXO4gWInwoGRLwYNV/UBxXxIIG1ilYjTa8gU9AGE6MOmSk5YPl5kKaOxdw7lcSE1q2iGnDmhoAlHg+oFtkCNaiXIgJg3L2nap37ZVsefxtH9/adKxhyYPBw
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> This fixes random EINPROGRESS at init or during runtime.
>
> Also correct whitespaces and make stdout more consistent.
>
> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
> ---
>  tidbits/oob-net-udp.c | 58 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 50 insertions(+), 8 deletions(-)
>
> diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
> index 11b8459..7af834f 100644
> --- a/tidbits/oob-net-udp.c
> +++ b/tidbits/oob-net-udp.c
> @@ -50,12 +50,12 @@ static void usage(void)
>  }
>  
>  static void print_addr(char* text, struct sockaddr_in *addr){
> -    char ip_str[INET_ADDRSTRLEN+1];
> -    inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
> -    evl_printf("%s--------\n", text);
> -    evl_printf("IP-Address: %s\n", ip_str);
> -    evl_printf("Port:       %d\n", ntohs(addr->sin_port));
> -    evl_printf("Family:     %d\n", addr->sin_family);
> +	char ip_str[INET_ADDRSTRLEN+1];
> +	inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
> +	evl_printf("== %s\n", text);
> +	evl_printf("   ip-address: %s\n", ip_str);
> +	evl_printf("   port:       %d\n", ntohs(addr->sin_port));
> +	evl_printf("   family:     %d\n", addr->sin_family);
>  }
>  
>  static void sender(int s, const char *text, int mcount,
> @@ -226,6 +226,8 @@ static void client(int s, const char *text, int mcount,
>  	free(tbuf);
>  }
>  
> +#define SERVER_ADDR_LIST_SIZE 64
> +
>  static void server(int s, const char *text, int mcount,
>  		struct sockaddr_in *addr, int iter)
>  {
> @@ -236,6 +238,9 @@ static void server(int s, const char *text, int mcount,
>  	ssize_t ret;
>  	char *tbuf;
>  	char rbuf[16384];
> +	in_addr_t addr_list[SERVER_ADDR_LIST_SIZE]={};
                                                  ^ missing whitespaces
> +	size_t addr_list_fill=0;
> +	bool solicit_done;
>  
>  	tlen = (strlen(text) + 1) * mcount;
>  	tbuf = malloc(tlen);
> @@ -276,6 +281,39 @@ static void server(int s, const char *text, int mcount,
>  			evl_printf(" (TRUNCATED)");
>  		evl_printf(": %.*s\n", (int)ret, rbuf);
>  
> +		/*
> +		 * We need to call evl_net_solicit for each new
> +		 * client once before sending data. This will break
> +		 * realtime for the first response.
> +		 * If this is not done and the ARP address is not
> +		 * yet in cache or garbage-collected, oob_sendmsg
> +		 * will return EINPROGRESS on start or during runtime.
> +		 */

We can happily send redundant solicit requests to the core, no need to
filter out cached addresses, evl_net_solicit() will do the right thing.

> +		solicit_done = false;
> +		for(size_t i = 0; i < addr_list_fill && !solicit_done; i++){

                   ^ missing whitespace

> +			if(addr_list[i] == _addr.sin_addr.s_addr){
                          ^ missing whitespace

> +				solicit_done = true;
> +			}
> +		}
> +		if(!solicit_done){
> +			if(verbosity){
> +				char ip_str[INET_ADDRSTRLEN+1];
> +				inet_ntop(AF_INET, &(_addr.sin_addr), ip_str, sizeof(ip_str));
> +				evl_printf("== client %s first seen: evl_net_solicit\n", ip_str);
> +			}
> +			ret = evl_net_solicit(s, (const struct sockaddr *)&_addr,
> +					EVL_NEIGH_PERMANENT);
> +			if (ret)
> +				error(1, -ret, "evl_net_solicit()");
> +
> +			if(addr_list_fill < SERVER_ADDR_LIST_SIZE){
> +				addr_list[addr_list_fill] = _addr.sin_addr.s_addr;
> +				addr_list_fill ++;
                                              ^ extraneous whitespace

> +			}else{
> +				error(1, EPERM, "address list full");
> +			}
> +		}
> +
>  		iov.iov_base = tbuf;
>  		iov.iov_len = tlen;
>  		msghdr.msg_iov = &iov;
> @@ -433,7 +471,7 @@ int main(int argc, char *argv[])
>  		receiver(s, &addr, iter);
>  	} else if (mode == CLIENT) {
>  		if (verbosity)
> -			printf("== client mode (<= %s:%d)\n", ip, port);
> +			printf("== client mode (<=> %s:%d)\n", ip, port);
>  
>  		/*
>  		 * Guarantee a mere oob path from the first packet
> @@ -449,8 +487,12 @@ int main(int argc, char *argv[])
>  		client(s, text, mcount, &addr, iter, delay);
>  	} else if (mode == SERVER) {
>  		if (verbosity)
> -			printf("== server mode (<= %s:%d)\n", ip, port);
> +			printf("== server mode (<=> %s:%d)\n", ip, port);
>  
> +		/*
> +		 * The server calls evl_net_solicit() internally
> +		 * for each new ip address.
> +		 */
>  		server(s, text, mcount, &addr, iter);
>  	} else {
>  		error(1, 0, "Mode not implemented");

-- 
Philippe.
