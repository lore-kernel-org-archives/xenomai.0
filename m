Message-ID: <51CC031A.9030905@xenomai.org>
Date: Thu, 27 Jun 2013 11:17:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <201306260906.22955.leo@alaxarxa.net>
	<51CB231E.8030600@xenomai.org>
	<201306271109.22749.leo@alaxarxa.net>
In-Reply-To: <201306271109.22749.leo@alaxarxa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai warn_upon_switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/27/2013 11:09 AM, Leopold Palomo-Avellaneda wrote:

>
> AAnd I don't know how to silent (or if is possible) this messages.

Try disabling CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX if currently set in your 
kernel config. If that is still not enough, then you will have to switch 
off PTHREAD_WARNSW manually, using pthread_set_mode_np(), for each 
thread which triggers this signal.

-- 
Philippe.

