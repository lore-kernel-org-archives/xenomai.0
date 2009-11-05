Message-ID: <4AF29E87.9090401@domain.hid>
Date: Thu, 05 Nov 2009 10:44:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <985eb86f0911050120l3a989588ida812a9394659a78@domain.hid>
In-Reply-To: <985eb86f0911050120l3a989588ida812a9394659a78@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] setting priority
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: tarek ben ali <tarekbenali@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, xenomai@xenomai.org

tarek ben ali wrote:
> 
> I'm trying to set priority to a specified process on including its
> PID,the code below is running BUT after allocating priority and policy 
> the output of "top" commande seems not changing(the priority of the
> process specified is still the same).Is there any explanation please?

Here we know a few things or two about Xenomai, not about top. So, I
have no idea. Now, if you are trying to set the priority of a Xenomai
thread using Xenomai posix skin, as I already told you in the previous
mail, you have to use services described here, not sched_setscheduler:

http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__posix__sched.html

-- 
                                          Gilles


