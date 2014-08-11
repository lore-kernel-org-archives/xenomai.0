References: <AE39D2A4-ECC3-481B-AF3B-8A67FA23D2BF@tuebingen.mpg.de>
 <44BE6908-E639-421F-B556-E7B3871402CF@gmail.com>
 <67B7E374-C4D2-4F83-BA40-B289B15867B9@tuebingen.mpg.de>
 <53E3B5E3.3090006@xenomai.org> <oqtx5om90q.fsf@merlin.sez.to>
 <53E3CD23.5040909@xenomai.org> <53E3D084.2000506@tuebingen.mpg.de>
 <53E3D2FF.5000407@xenomai.org> <53E3D50D.7060701@tuebingen.mpg.de>
 <53E3D712.3070801@xenomai.org> <web-589558@tuebingen.mpg.de>
 <53E47905.5070402@xenomai.org> <oqoavunbgo.fsf@merlin.sez.to>
 <53E5081C.8050807@xenomai.org> <oqiom2n8ex.fsf@merlin.sez.to>
 <53E7964B.6080200@xenomai.org> <oq8umvm0fr.fsf@merlin.sez.to>
 <53E8FC9C.90508@xenomai.org>
From: Paul Janzen <pcj@xenomai.sez.to>
Date: Mon, 11 Aug 2014 10:43:30 -0700
In-Reply-To: <53E8FC9C.90508@xenomai.org> (Gilles Chanteperdrix's message of
 "Mon, 11 Aug 2014 19:25:48 +0200")
Message-ID: <oq38d2ncql.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai] real-time guarantee issues on xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:

> What about combining the 2, like:
>
> 	} else {
> 		xnarch_memory_barrier();
> 		cpu_relax();
> 	}

No, this does not help either.

-- Paul

