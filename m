From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17460.65490.533332.374578@domain.hid>
Date: Thu, 6 Apr 2006 13:47:30 +0200
Subject: Re: [Xenomai-core] Problem compiling POSIX skin for mvm
In-Reply-To: <f48df4840604051439g309cc53eoda87f81552c19a34@domain.hid>
References: <f48df4840604051439g309cc53eoda87f81552c19a34@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bruno Rouchouse <brouchouse@domain.hid>
Cc: xenomai@xenomai.org

Bruno Rouchouse wrote:
 > Hi !
 > 
 > Just having a little problem compiling my posix skin for the simulator.
 > GFP_USER doesn't seem to be defined anywhere. Did I misconfigure something ?
 > Does it have something to do with the one defined in
 > /usr/include/linux/gfp.h ?

This should be fixed by revision 893.

-- 


					    Gilles Chanteperdrix.

