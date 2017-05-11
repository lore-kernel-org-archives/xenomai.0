References: <4dde2217-0520-3b4d-7aa3-2393a0e2c88c@sigmatek.at>
 <b09e3a3a-8f90-5536-d226-c18f70d4cec4@xenomai.org>
 <b951310c-e367-6862-f06a-40649f24730b@sigmatek.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <04c24372-5fd7-4827-f51e-cb1bc248a338@xenomai.org>
Date: Thu, 11 May 2017 18:37:44 +0200
MIME-Version: 1.0
In-Reply-To: <b951310c-e367-6862-f06a-40649f24730b@sigmatek.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] =?utf-8?q?Gatekeeper_taking_1ms_instead_of_13=C2=B5s?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>, Xenomai Mailing List <xenomai@xenomai.org>

On 05/11/2017 05:49 PM, Wolfgang Netbal wrote:

> Do you have any idea why my Xenomaitask with prio 80
> did not interrupt the gatekeeper ?

Because this task is not running in primary mode.

-- 
Philippe.

