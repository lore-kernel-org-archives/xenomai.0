Message-ID: <4EE4D43D.9080709@domain.hid>
Date: Sun, 11 Dec 2011 17:03:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1322654284-6867-1-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1322654284-6867-1-git-send-email-wolfgang.mauerer@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 0/2] Fasteoi fixes
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: jan.kiszka@domain.hid, adeos-main@gna.org, gernot.hillier@domain.hid

On 11/30/2011 12:58 PM, Wolfgang Mauerer wrote:
> Dear all,
>
> following Jan's considerations, I found that we lack a generic
> bug fix for the fasteoi handler in 2.6.38, which is backported
> in the first patch. The second patch makes ipipe agree with
> threaded one-shot handlers.
>
> Pending adaption to the latest API, this part is also relevant
> for the ipipe-3.0-noarch. Philippe, do you agree with the
> approach?
>

Fine with me. Merged, thanks.

> Cheers, Wolfgang
>
> --
> Siemens AG, Open Source Platforms,
> Corporate Competence Centre Embedded Linux
>
>


-- 
Philippe.

