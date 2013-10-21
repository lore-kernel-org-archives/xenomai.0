Message-ID: <52656F1E.9020701@xenomai.org>
Date: Mon, 21 Oct 2013 20:14:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BLU0-SMTP919B70F18235329A81D0D5AF010@phx.gbl>
In-Reply-To: <BLU0-SMTP919B70F18235329A81D0D5AF010@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] HELP with xeno-test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Chiara <chiaracapretti@hotmail.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/21/2013 08:09 PM, Chiara wrote:
> Hi everyone!
> 
> I've got a problem..I try the command xeno-test.
> I put this command
> 
> sudo xeno-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp" -p 100 -g histo
> 
> but I obtained 
> 
> "illegal option -g"
> 
> so I substitute with -h (even if it shouldn't give the same result)
> 
> after, the command start but I obtained a list of "something died at 17272"
> 
> If I do only the command latency, everything goes ok..what can I do? 

Please install xenomai latest version i.e. xenomai 2.6.3.

-- 
                                                                Gilles.

