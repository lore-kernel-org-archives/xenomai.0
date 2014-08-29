Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <3C04D010-D511-4D3D-A90E-474B71DA6425@gatech.edu>
Date: Thu, 28 Aug 2014 23:03:20 -0400
Content-Transfer-Encoding: 7bit
Message-Id: <F53A2B7B-98B9-45F2-AE6A-A9B336653267@gatech.edu>
References: <7DEE8379-159F-470A-B22D-01B16FBEECB3@gatech.edu>
 <3C04D010-D511-4D3D-A90E-474B71DA6425@gatech.edu>
Subject: Re: [Xenomai] Analogy PCI Slot issues?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Sorry to spam the email.

Just found the solution and posting incase it helps anyone else.

For some reason the following works without specifying a bus address.

$ sudo analogy_config analogy0 analogy_ni_pcimio

Yogi

