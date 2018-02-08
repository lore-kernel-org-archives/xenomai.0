Message-ID: <1518078950.2970.3.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Thu, 08 Feb 2018 09:35:50 +0100
In-Reply-To: <b7dd0f59-098c-25b4-46e8-ca60250c01cd@xenomai.org>
References: <1517561505.2571.7.camel@sprinte.eu>
 <b7dd0f59-098c-25b4-46e8-ca60250c01cd@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Multiplexing and rtcan socket
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Le dimanche 04 février 2018 à 10:58 +0100, Philippe Gerum a écrit :
> On 02/02/2018 09:51 AM, Julien Blanc wrote:
> > 
> > I'm trying to use multiplexing wih rtcan sockets (using
> > xeno_can_flexcan driver).
> > 
> > 
> > Is it unsupported, or am i doing something wrong ? (like a missing
> > parameter). Sample code to reproduce the issue is attached.
> > 
> The RTCAN stack predates the implementation of select(), and was
> never 
> updated to provide this, hence ENODEV. If somebody volunteers to
> provide 
> this, this should likely go into the code implementing the raw CAN
> socket.

Thanks for your answer. I unfortunately will have no time to spend on
this in the near future, since this is not a critical issue for us.

I'll look into it when possible, though, it would be a very nice to
have feature.

Regards,

Julien

