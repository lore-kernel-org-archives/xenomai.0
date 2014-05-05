Message-ID: <53676B5A.4060909@xenomai.org>
Date: Mon, 05 May 2014 12:43:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <DUB121-W16C3D6303DA348F2821C53814C0@phx.gbl>
In-Reply-To: <DUB121-W16C3D6303DA348F2821C53814C0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Round-robin "unknown error -3"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mobin Motallebizadeh <mobin.seven@live.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/05/2014 12:04 PM, mobin Motallebizadeh wrote:
> I used the "round-robin-example.c" and got the "round-robin-example-output".the first task returns 0 (success) and works correctlyothers return -3.what am I doing wrong.thanks in advance 		 	   		

-ESRCH, unknown task. Your demo task exits after 200 ms runtime.

-- 
Philippe.

