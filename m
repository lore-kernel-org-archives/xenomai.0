Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAA738F230
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305022; cv=none; b=VUwdVjt0Djlh6NyVDJs0iEEkmSnQdRRqcc6oFXKy/I93JyFQ50bWc3vs5W4ILq8B5nTn0gjGG8g1gLFt7UhsD4G02qfqgWnrWbp21LCSZ09xNY9/ALP5fAmQcQeyjImA3JqrEWkWhhkFewZ36+w/4AS/bWp4c3DmXUsonG2DZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305022; c=relaxed/simple;
	bh=0BZE9+byNsMGg1mXniYX+ahBPzdIZ5BM5jTOAICZdfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgU0p/3whkYM3YnQZTyZKoZnqQGaeWq3hjivuWL8HOtmF5qF9HDWWUp5lxvEOvYb49qbhnZrzrFjb75y1Lnnf2wqg1Yp77dOZggoNiTkZf0hXa7UEf2rJ+2XHbOftBx2vFOY5dWO2r+MhxtKYXGiZR2fB8CAga3lIS3vVu867BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=T9gih7ss; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="T9gih7ss"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E514D3EB9E;
	Mon,  1 Jun 2026 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780305018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2rZhTSwE03pWjwP/eoAHiRppOXCqEdYj0+35CnPohE=;
	b=T9gih7ssloIWH4POtPahAFO6H96rJZbOOZjtHdl09f0WkUBmGM/EZaCY8FVvuAVEqyovoe
	1W8u2sL19sH445uGZ+NAY6n6fxKpexQrf7t+uZ4d2JuRBKLjGwnB1Aw3Np5pJb2HamGhLd
	bScjRNgn3vrK8AWusR2VjpMOfrga40cRTI2zMppTb6yXzBVUe8gp54MwHlWtaAu3+UqGGS
	DiOzeYKtB7s55gw/nXaAqAZUfNyh/zd/qnRcti65zcLBkGsnOx16R2awb/Ctx/AXeaG0xz
	R193qqZY1HVSbUrlq9ZgtY6H34fkB/OsK/rUa1rI8G1Non8NMbyahLJugdON8A==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
In-Reply-To: <87a4te64vn.fsf@xenomai.org> (Philippe Gerum's message of "Mon,
	01 Jun 2026 10:29:00 +0200")
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
	<20260528194459.6117-2-hannes.diethelm@gmail.com>
	<87a4te64vn.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 01 Jun 2026 11:10:17 +0200
Message-ID: <874ijm62yu.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEQmBNlYI7UmmKxzgR76fHKJVYlp4wWBc2v1odaIVcqUV1hqFvx7nTr2gD06Ti8PNUlkG69VD5km33w0vE3qCQLtTw0acfSXqlkigTjxtXMyE4mGsWz+yaW24lICJnL1rpfDUXIGhDuyJq/Cct7iKE7qvL3IJ+zP8LsrD+Ay8XeHAxKS38lwArUC4KqmcRV78/wDyZIfwIY4JGXpid/ucLZ3cs0okvGdLozR8NPyOQ+i8kf53LK8IgkBQDvMFXhmkpW2gbjt50A7ccMqklqD3HDHWY/sA/gLXtpGkYgisQ/KrkIhxsgFVxfSceilnQvhdKh4+0IAEd8PrXKYPlUAD6Tl2QWbtMmQBBJTous8ut8SwP7D46Yqx46eGR3bx+RUIWO+HJXyrqopXnooICd+CxEYEcXNwWF+j9MrulXskRlnMYu2KM5r1OqkvmYHLh2FzhMUORj7+GcJVu2ObEa1t0OHpxzFyJlO/btx/eTHI5qc6RIi/CVd/WaUCKuKVf9VBVR+8zCyIKnexV89RJ/hCpsfWzMlY9uebPa8Hy6hpjoCpPq5enk7JvqZWNmy1zW+hfwNbGs08J3IouhU8Rd7bWz42uifb2ONAwSM+K0D7wKSu1RqaWCN8M2vQi/gNhOxZlRqA2vdBrCl3exI2dX0wO5dxmBgXymTGG2HVVY+xf3cw

Philippe Gerum <rpm@xenomai.org> writes:

> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>
>> This fixes random EINPROGRESS at init or during runtime.
>>
>> Also correct whitespaces and make stdout more consistent.
>>
>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>> ---
>>  tidbits/oob-net-udp.c | 58 +++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 50 insertions(+), 8 deletions(-)
>>
>> diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
>> index 11b8459..7af834f 100644
>> --- a/tidbits/oob-net-udp.c
>> +++ b/tidbits/oob-net-udp.c
>> @@ -50,12 +50,12 @@ static void usage(void)
>>  }
>>  
>>  static void print_addr(char* text, struct sockaddr_in *addr){
>> -    char ip_str[INET_ADDRSTRLEN+1];
>> -    inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
>> -    evl_printf("%s--------\n", text);
>> -    evl_printf("IP-Address: %s\n", ip_str);
>> -    evl_printf("Port:       %d\n", ntohs(addr->sin_port));
>> -    evl_printf("Family:     %d\n", addr->sin_family);
>> +	char ip_str[INET_ADDRSTRLEN+1];
>> +	inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
>> +	evl_printf("== %s\n", text);
>> +	evl_printf("   ip-address: %s\n", ip_str);
>> +	evl_printf("   port:       %d\n", ntohs(addr->sin_port));
>> +	evl_printf("   family:     %d\n", addr->sin_family);
>>  }
>>  
>>  static void sender(int s, const char *text, int mcount,
>> @@ -226,6 +226,8 @@ static void client(int s, const char *text, int mcount,
>>  	free(tbuf);
>>  }
>>  
>> +#define SERVER_ADDR_LIST_SIZE 64
>> +
>>  static void server(int s, const char *text, int mcount,
>>  		struct sockaddr_in *addr, int iter)
>>  {
>> @@ -236,6 +238,9 @@ static void server(int s, const char *text, int mcount,
>>  	ssize_t ret;
>>  	char *tbuf;
>>  	char rbuf[16384];
>> +	in_addr_t addr_list[SERVER_ADDR_LIST_SIZE]={};
>                                                   ^ missing whitespaces
>> +	size_t addr_list_fill=0;
>> +	bool solicit_done;
>>  
>>  	tlen = (strlen(text) + 1) * mcount;
>>  	tbuf = malloc(tlen);
>> @@ -276,6 +281,39 @@ static void server(int s, const char *text, int mcount,
>>  			evl_printf(" (TRUNCATED)");
>>  		evl_printf(": %.*s\n", (int)ret, rbuf);
>>  
>> +		/*
>> +		 * We need to call evl_net_solicit for each new
>> +		 * client once before sending data. This will break
>> +		 * realtime for the first response.
>> +		 * If this is not done and the ARP address is not
>> +		 * yet in cache or garbage-collected, oob_sendmsg
>> +		 * will return EINPROGRESS on start or during runtime.
>> +		 */
>
> We can happily send redundant solicit requests to the core, no need to
> filter out cached addresses, evl_net_solicit() will do the right thing.
>

Except that doing so would always demote the caller to the in-band
stage, which may not be what you want. The fact that we'd need to
maintain a cache in apps in order to figure out whether solicitation
should be done shows a shortcoming in the core, users should not have to
do this dance.

We should have an oob call for probing the route+arp caches with
ipv4. I'll look into this asap.

-- 
Philippe.
