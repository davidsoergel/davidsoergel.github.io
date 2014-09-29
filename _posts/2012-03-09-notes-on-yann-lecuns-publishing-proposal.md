---
title: 'Notes on Yann LeCun&#8217;s publishing proposal'
author: David Soergel
layout: post
permalink: /2012/03/09/notes-on-yann-lecuns-publishing-proposal/
categories:
  - Academia
---
These are brainstorms on Yann LeCun&#8217;s pamphlet, [A New Publishing Model in Computer Science][1].  
<!--more-->

## The initial review period

*   REs competing to rate the best papers first: does this create a first post race, favoring shallow over deep reviews? Maybe all reviews should be embargoed to some date (i.e., 1-2 weeks after publication) and released simultaneously. In fact, what&#8217;s the rush to be first to review? Is that worth more points (or, there is a multiplier on the karma associated with the review, to reward promptness)?
*   When an author requests a review from a specific RE, reviews from other RE&#8217;s should be embargoed&#8211; that is, the designated RE gets a lock on the paper for 2 weeks, so that they can give it full attention without getting scooped.
*   Could allow a double-blind option for extra karma. That is: I might get 1.2x karma for reviewing something without knowing the authors. Upon submission, give authors the option for a 2-week blind period. Careful that someone&#8217;s &#8220;anonymous&#8221; karma increments vs. time don&#8217;t reveal what what they reviewed (maybe keep a &#8220;private&#8217; karma pool which trickles into the public score randomly over time, to obscure the source).
*   Bad papers pose no reviewing burden: circular. How do you know they&#8217;re bad?
*   On reviews being first-class papers: yes, but reviews likely lack formal structure and may be less well written; tweets are on the end of that continuum. For that matter a simple upvote is a one-bit &#8220;review&#8221;. Conversely a really detailed rebuttal of something may take the form of a full paper. How does credit scale with length & effort?

## Paper revisions

*   When a paper is updated, what happens to its reviews? They&#8217;re still connected to the old version. Is it expected that the reviewers will review the update as well, to indicate whether their concerns were adequately addressed? How many rounds are expected? 
*   When is a paper &#8220;done&#8221;? Maybe there should be some time limit, say 12 months, after which that paper is fixed and any updates must take the form of a new paper (or a retraction)
*   Authors could tag work on the brainstorms->done scale. B. Schoelkopf points out that journals publish complete work, but conferences may accept work in progress.
*   How much credit arises from a good revision vs. a good original paper? Will there be a perverse incentive to submit a &#8220;new&#8221; paper that is really an untracked revision of the old one?
*   What if a paper gets a great review, but then a later version introduces a fatal bug? Does the great review still grant credit? Or, is the reviewer responsible to add a negative review of the later update?
*   To address the concern that a bad review may stick with a naive young grad student for a long time: if the reviewer accepts a later revision, allow the original bad review to be hidden. (I.e. the record that it happened should remain, so that the reviewer gets credit). Maybe it costs the author a few karma points to hide the review, and it should require the consent of the reviewer, and maybe copying any outstanding issues into the updated review.

## Karma assignment

*   Should really bad papers get negative points, instead of just being ignored? Yes. Disincent flooding with crap.
*   If reviewing a paper that later becomes successful benefits the reviewer, then there might be &#8220;gold rush&#8221; to submit not-very-helpful reviews on lots of papers that are already getting good reviews or that come from infuential labs. So the credit to the reviewer accruing via a successful paper must be multiplied by the quality of the review itself. Maybe nonlinearly: e.g. a review gains no credit until it has at least five upvotes, etc.
*   The karma system may reflect not just quality but also politics: people may trash others they don&#8217;t like, etc. Converse of rich get richer: people may get shut out on purpose. The hope is that personal squabbles will be noise, drowned out by unbiased reviews. If the whole community really shuts out a person or topic, well, that&#8217;s the way it is (as the climate change deniers complain), and our modeling it is legit.
*   Computing karma flow on the citation graph requires sentiment analysis. E.g. &#8220;in contrast to the boneheaded claims of Fritz et al. 2004, &#8230;&#8221; might produce negative karma for Fritz.
*   On the other hand, if we&#8217;re measuring paper visibility, not paper quality, then a negative-sentiment citation is still a &#8220;good&#8217; thing: the paper must have been visible enough to get cited in the first place, and now it&#8217;s even more so.
*   Need to support multiple scoring schemes, which amounts to the same thing as multidimensional scores. A person may accrue karma form lots of average papers or from a few good ones, or primarily from reviews (not papers, if there is any distinction anyway), etc. (Similar reason for different bibliometric scoring schemes e.g. H-index etc.)
*   Fractional authorship allows &#8220;acknowledged&#8221; people to get a bit of credit (e.g., 1%). The other part of authorship is vouching for the contents; either make this distinction explicitly, or just have a rule that authors > 5% are not responsible. Also, acknowledgement does not require consent, but authorship does.

## Conference mechanics

*   Highly rated people should be invited to the conference and/or given travel awards. Sets up competition to get to go.
*   System could allocate conference presentation time according to author request (i.e. based on the length & difficulty of the paper), reviewer request, and karma. E.g. one paper gets a 17-minute slot, another 6 minutes, etc.

## Cultural issues

*   Could get awkward if a grad student has a higher score than a PI.
*   The big impact of the short-term conference site might be to make us a focus of discussion about how academic publishing can be fixed; i.e. our &#8220;meta&#8221; site becomes the place where this topic gets discussed.

## Other notes

*   In my [undergrad thesis][2] (14 years ago!), I covered the basic idea of the Reviewing Entity as essentially a node in a distributed trust network&#8211; and surely the concept was not new then either. The idea that we rely on external authorities to give us information, but that we trust them to varying degrees and for different purposes, is self-evident. It&#8217;s just a matter of finding and implementing the right abstraction for that fact.

 [1]: http://yann.lecun.com/ex/pamphlets/publishing-models.html
 [2]: http://www.davidsoergel.com/soergel-organism.pdf